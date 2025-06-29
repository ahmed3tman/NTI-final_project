import 'package:api_cubit_task/core/features/cart/cubit/cart_cubit.dart';
import 'package:api_cubit_task/core/features/cart/cubit/cart_state.dart';
import 'package:api_cubit_task/core/features/home/model/lap_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final LapModel laptop;

  const DetailsScreen({super.key, required this.laptop});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _selectedImageIndex = 0;
  bool _wasAddingToCart = false;
  bool _showSuccessState = false;
  bool _showErrorState = false;

  List<String> get allImages {
    final images = [widget.laptop.image, ...widget.laptop.images];
    return images.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final images = allImages;

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          if (_wasAddingToCart &&
              !state.addingItems.contains(widget.laptop.id)) {
            setState(() {
              _wasAddingToCart = false;
              _showSuccessState = true;
              _showErrorState = false;
            });

            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _showSuccessState = false;
                });
              }
            });
          } else if (state.addingItems.contains(widget.laptop.id)) {
            setState(() {
              _wasAddingToCart = true;
              _showSuccessState = false;
              _showErrorState = false;
            });
          }
        } else if (state is CartError && _wasAddingToCart) {
          setState(() {
            _wasAddingToCart = false;
            _showSuccessState = false;
            _showErrorState = true;
          });

          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _showErrorState = false;
              });
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(
            widget.laptop.name,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.blueGrey[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blueGrey[900]),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                    border: Border.all(color: Colors.blueGrey[100]!, width: 2),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.network(
                        images[_selectedImageIndex],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.error,
                            size: 48,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (images.length > 1)
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: images.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedImageIndex == index
                                  ? Colors.blue[700]!
                                  : Colors.blueGrey[100]!,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                images[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.laptop.name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                            ),
                          ),
                        ),
                        Chip(
                          label: Text(
                            widget.laptop.category,
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: Colors.blue[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'by ${widget.laptop.company}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.blueGrey[400],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Text(
                          '\$${widget.laptop.price.toStringAsFixed(2)}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                widget.laptop.status.toLowerCase() ==
                                    'available'
                                ? Colors.green[100]
                                : Colors.red[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.laptop.status,
                            style: TextStyle(
                              color:
                                  widget.laptop.status.toLowerCase() ==
                                      'available'
                                  ? Colors.green[800]
                                  : Colors.red[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${widget.laptop.countInStock} in stock',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        final isLoading =
                            state is CartLoaded &&
                            state.addingItems.contains(widget.laptop.id);

                        return Container(
                          decoration: BoxDecoration(
                            gradient: _showSuccessState
                                ? null
                                : _showErrorState
                                ? null
                                : const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF667eea),
                                      Color(0xFF764ba2),
                                    ],
                                  ),
                            color: _showSuccessState
                                ? Colors.green.shade600
                                : _showErrorState
                                ? Colors.red.shade600
                                : null,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (_showSuccessState
                                            ? Colors.green
                                            : _showErrorState
                                            ? Colors.red
                                            : Colors.purple)
                                        .withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed:
                                widget.laptop.countInStock > 0 &&
                                    !isLoading &&
                                    !_showSuccessState &&
                                    !_showErrorState
                                ? () {
                                    HapticFeedback.lightImpact();
                                    context.read<CartCubit>().addCart(
                                      lapId: widget.laptop.id,
                                    );
                                  }
                                : null,
                            icon: _showSuccessState
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                : _showErrorState
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                : isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                            label: Text(
                              _showSuccessState
                                  ? 'Added Successfully!'
                                  : _showErrorState
                                  ? 'Failed to Add'
                                  : isLoading
                                  ? 'Adding...'
                                  : widget.laptop.countInStock > 0
                                  ? 'Add to Cart'
                                  : 'Out of Stock',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Description',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.laptop.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.blueGrey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
