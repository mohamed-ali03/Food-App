import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';

// responsive : done

class AccountProfileHeader extends StatelessWidget {
  final dynamic user;
  final VoidCallback? onEditImage;

  const AccountProfileHeader({required this.user, this.onEditImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.blockHight * 4),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: SizeConfig.blockHight * 7.5,
                backgroundColor: Colors.white,
                backgroundImage:
                    user.imageUrl != null && user.imageUrl!.isNotEmpty
                    ? CachedNetworkImageProvider(user.imageUrl!)
                    : null,
                child: user.imageUrl == null || user.imageUrl!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: SizeConfig.blockHight * 7.5,
                        color: Colors.grey[400],
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: SizeConfig.blockHight * 0.5,
                        offset: Offset(0, SizeConfig.blockHight * 0.25),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: SizeConfig.blockHight * 2.5,
                    ),
                    color: Colors.blue,
                    onPressed: onEditImage,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockHight * 2),
          Text(
            user.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.blockHight * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SizeConfig.blockHight),
        ],
      ),
    );
  }
}
