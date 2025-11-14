// ChatPage.dart

import 'dart:async';
import 'dart:convert';
import 'auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Controller for text input field
  final TextEditingController _controller = TextEditingController();

  // Controller for managing scroll behaviour in chat list
  final ScrollController _scrollController = ScrollController();

  // Manages focus state of text field (for keyboard control)
  final FocusNode _focusNode = FocusNode();

  bool _showScrollFAB = false; // Whether to show "scroll down" button
  bool _isLoading = false; // Track the API request is in progress
  List<Map<String, String>> _messages = []; // Stores chat history

  @override
  void initState() {
    super.initState();
    // Automatically focus text field when screen loads (might cause lag in the app - can remove later)
    /* WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
 */
    // Delay focus to prevent keyboard lag
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _focusNode.requestFocus();
    });

    // Listen to scroll events to show/hide scroll-down button
    _scrollController.addListener(() {
      if (!mounted) return; // Prevent state updates if widget is removed

      // Check if user has scrolled up (100 pixels from bottom)
      final atBottom =
          _scrollController.offset >=
          _scrollController.position.maxScrollExtent - 100;

      // Only update state if visibility needs to change
      if (_showScrollFAB == atBottom) {
        setState(() => _showScrollFAB = !atBottom);
      }
    });
  }

  @override
  void dispose() {
    // Clean up controllers to prevert memory leaks
    _scrollController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    // Smart scrolling: Jump if far from bottom, animate if near
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.pixels + 500 <
          _scrollController.position.maxScrollExtent) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage() async {
    if (_isLoading) return; // Prevent multiple simultaneous requests
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    // Update state with new user message and loading status
    setState(() {
      _messages = [
        ..._messages,
        {'role': 'user', 'text': message},
      ];
      _isLoading = true;
    });

    _scrollToBottom(); // Immediately show new message

    try {
      // Api call with 30-second timeout
      final response = await http
          .post(
            Uri.parse(
              'http://< PCs IP : 5000>/askques',
            ), // your laptop's IP address with port (5000 here)
            headers: {'Content-type': 'application/json'},
            body: jsonEncode({'question': message}),
          )
          .timeout(const Duration(seconds: 30));

      // Handle successful response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['summary'] ?? 'No Response';
        _messages = [
          ..._messages,
          {'role': 'bot', 'text': botReply},
        ];
      } else {
        // Handle server errors
        _messages = [
          ..._messages,
          {'role': 'bot', 'text': 'Server error: ${response.statusCode}'},
        ];
      }
    } catch (e) {
      // Handle network/timeout errors
      _messages = [
        ..._messages,
        {'role': 'bot', 'text': 'Error: $e'},
      ];
    } finally {
      // Final cleanup after API call
      if (mounted) {
        // Check if widget still exists
        setState(() {
          _isLoading = false;
          _controller.clear();
        });
        _scrollToBottom();
        _focusNode.requestFocus(); // Return focus to text field
      }
    }
  }

  // Clear all the messages (delete chat history)
  void clearMessages() {
    if (mounted) {
      setState(() {
        _messages.clear();
        _isLoading = false;
      });
    }
  }

  // Show clear chat confirmation dialog box alert to the user before actually deleting the chat history
  void showClearChatConfirmation() {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text('Clear Chat'),
            content: const Text(
              'Are you sure you want to delete the entire chat?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // close the dialog box
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context); // First, close the side-drawer
                  clearMessages(); // then, clear the entire chat
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFADAD), // Light red color
      ),
      drawer: const ChatDrawer(),
      body: Column(
        children: [
          // Chat message area (takes most of the screen)
          Expanded(
            child: ChatMessages(
              messages: _messages,
              isLoading: _isLoading,
              scrollController: _scrollController,
              showScrollFAB: _showScrollFAB,
              scrollToBottom: _scrollToBottom,
            ),
          ),
          // Input field at bottom
          ChatInput(
            controller: _controller,
            focusNode: _focusNode,
            isLoading: _isLoading,
            scrollToBottom: _scrollToBottom,
            scrollController: _scrollController,
            onSend: sendMessage,
          ),
        ],
      ),
    );
  }
}

// Separate widget for chat messages list (optimizes rebuilds)
class ChatMessages extends StatelessWidget {
  final List<Map<String, String>> messages;
  final bool isLoading;
  final ScrollController scrollController;
  final bool showScrollFAB;
  final VoidCallback scrollToBottom;

  const ChatMessages({
    // Constructor
    super.key,
    required this.messages,
    required this.isLoading,
    required this.scrollController,
    required this.showScrollFAB,
    required this.scrollToBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: messages.length + (isLoading ? 1 : 0),
          itemExtent: 80, // Improves performance by fixing item heights
          addAutomaticKeepAlives: true, // Preserves state of off-screen items
          addRepaintBoundaries: true, // Optimizes painting of list items
          itemBuilder: (context, index) {
            // Show tying indicator when loading
            if (isLoading && index == messages.length) {
              return const TypingIndicator();
            }
            // Render chat message bubble
            final message = messages[index];
            return MessageBubble(
              message: message,
              isUser: message['role'] == 'user',
            );
          },
        ),
        // Scroll-to-bottom floating button
        if (showScrollFAB)
          Positioned(
            bottom: 20,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.blue,
              onPressed: scrollToBottom,
              child: const Icon(Icons.arrow_downward, color: Colors.white),
            ),
          ),
      ],
    );
  }
}

// Reusable message bubble content
class MessageBubble extends StatelessWidget {
  final Map<String, String> message;
  final bool isUser;

  const MessageBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12), // Padding
        margin: const EdgeInsets.symmetric(
          vertical: 6,
        ), // Margin: Space between the chat-bubbles
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message['text'] ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// Animated typing indicator widget
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            CircleAvatar(child: Icon(Icons.smart_toy_outlined, size: 16)),
            SizedBox(width: 10),
            // Animated three bouncing dots
            SpinKitThreeBounce(color: Colors.grey, size: 18.0),
          ],
        ),
      ),
    );
  }
}

// Dedicated widget for input field and send button
class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isLoading;
  final VoidCallback scrollToBottom;
  final ScrollController scrollController;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isLoading,
    required this.scrollToBottom,
    required this.scrollController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Expanded makes text field take available horizontal space
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                filled: true,
                fillColor: Colors.grey[200], // Light grey background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              textInputAction:
                  TextInputAction
                      .send, // Replaces the enter button with send button in mobile's keyboard
              onSubmitted: (value) {
                !isLoading ? onSend() : null;
                focusNode.requestFocus();
                scrollToBottom();
                
                // Only handle focus/scroll after the message is processed
                /* WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Check if scroll is needed (content exceeds viewport)
                  if (scrollController.position.maxScrollExtent > 0) {
                    scrollToBottom();
                  }

                  // Only refocus if the field is still visible
                  if (focusNode.context != null &&
                      focusNode.context!.findRenderObject()?.attached == true) {
                    focusNode.requestFocus();
                  }
                }); */
              },
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: isLoading ? null : onSend,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isLoading ? Colors.grey : const Color(0xFFFFADAD),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}

// Navigation drawer component
/* class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Options',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Clear Chat'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Access parent ChatPage's method
              context
                  .findAncestorStateOfType<_ChatPageState>()
                  ?.showClearChatConfirmation();
            },
          ),
        ],
      ),
    );
  }
} */

// Navigation drawer component
class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Options',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          // CLEAR CHAT
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Clear Chat'),
            onTap: () {
              Navigator.pop(context); // Close drawer
              context
                  .findAncestorStateOfType<_ChatPageState>()
                  ?.showClearChatConfirmation();
            },
          ),

          const Divider(),

          // LOGOUT BUTTON
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Clear login info
              loggedInEmail = null;
              loggedInName  = null;

              // Navigate to login screen
              // Navigator.pushReplacementNamed(context, '/login');
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
