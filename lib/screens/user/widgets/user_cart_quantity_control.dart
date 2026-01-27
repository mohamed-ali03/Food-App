import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';

// responsive : done

class QuantityControl extends StatefulWidget {
  final int quantity;
  final Function(int) onChangeQuantity;
  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onChangeQuantity,
  });

  @override
  State<QuantityControl> createState() => _QuantityControlState();
}

class _QuantityControlState extends State<QuantityControl> {
  late ValueNotifier<int> quantity;

  @override
  void initState() {
    quantity = ValueNotifier(widget.quantity);
    super.initState();
  }

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, size: SizeConfig.blockHight * 2),
            onPressed: () {
              if (quantity.value > 1) {
                quantity.value--;
                widget.onChangeQuantity(quantity.value);
              }
            },
            splashRadius: SizeConfig.blockHight * 2,
            constraints: BoxConstraints(
              minWidth: SizeConfig.blockHight * 2,
              minHeight: SizeConfig.blockHight * 2,
            ),
            padding: EdgeInsets.zero,
          ),
          ValueListenableBuilder(
            valueListenable: quantity,
            builder: (context, value, child) {
              return Text(
                '$value',
                style: TextStyle(
                  fontSize: SizeConfig.blockHight * 2,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add, size: SizeConfig.blockHight * 2),
            onPressed: () {
              // Increase quantity
              quantity.value++;
              widget.onChangeQuantity(quantity.value);
            },
            splashRadius: SizeConfig.blockHight * 2,
            constraints: BoxConstraints(
              minWidth: SizeConfig.blockHight * 2,
              minHeight: SizeConfig.blockHight * 2,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
