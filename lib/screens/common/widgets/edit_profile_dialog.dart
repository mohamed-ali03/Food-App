import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/functions.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/user%20model/user_model.dart';
import 'package:foodapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

// responsive : done

class EditProfileDialog extends StatefulWidget {
  final UserModel? user;
  final String field;

  const EditProfileDialog({super.key, required this.user, required this.field});

  @override
  State<EditProfileDialog> createState() => EditProfileDialogState();
}

class EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _controller;
  bool _isUploadingImage = false;
  String? _imageUrl;
  final UploadImage _uploadImage = UploadImage();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.field == 'name') {
      _controller = TextEditingController(text: widget.user?.name);
    } else if (widget.field == 'phone') {
      _controller = TextEditingController(text: widget.user?.phoneNumber ?? '');
    } else {
      _controller = TextEditingController();
      _imageUrl = widget.user?.imageUrl;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleImageUpload() async {
    setState(() => _isUploadingImage = true);

    final file = await _uploadImage.pickImage();
    if (file == null) {
      setState(() => _isUploadingImage = false);
      return;
    }

    _imageUrl = await _uploadImage.uploadImage('user_pic', file);

    if (mounted) {
      if (_imageUrl!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).t('failedToUploadImage'),
            ),
          ),
        );
      }
      setState(() => _isUploadingImage = false);
    }
  }

  void _save() async {
    if (widget.field == 'image') {
      if (_imageUrl != null && _imageUrl!.isNotEmpty) {
        await context.read<AuthProvider>().updateProfile(
          widget.user?.authID ?? '',
          imageUrl: _imageUrl,
        );
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).t('profilePictureUpdated'),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (widget.field == 'name') {
      await context.read<AuthProvider>().updateProfile(
        widget.user?.authID ?? '',
        name: _controller.text,
      );
    } else if (widget.field == 'phone') {
      await context.read<AuthProvider>().updateProfile(
        widget.user?.authID ?? '',
        phoneNumber: _controller.text.isEmpty ? null : _controller.text,
      );
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).t('profileUpdatedSuccessfully'),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.field == 'image') {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).t('updateProfilePicture')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.blockWidth * 25,
                height: _imageUrl != null && _imageUrl!.isNotEmpty
                    ? null
                    : SizeConfig.blockWidth * 25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(
                    SizeConfig.blockHight * 1.5,
                  ),
                  color: Colors.grey[100],
                ),
                child: _imageUrl != null && _imageUrl!.isNotEmpty
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              SizeConfig.blockHight * 1.5,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: _imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _imageUrl = null;
                              });
                            },
                            icon: Icon(
                              Icons.highlight_remove_sharp,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: _isUploadingImage ? null : _handleImageUpload,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_isUploadingImage)
                              const CircularProgressIndicator()
                            else ...[
                              Icon(
                                Icons.image,
                                size: SizeConfig.blockWidth * 12,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: SizeConfig.blockHight),
                              Text(
                                AppLocalizations.of(context).t('tapToUpload'),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
              if (_imageUrl != null && _imageUrl!.isNotEmpty) ...[
                SizedBox(height: SizeConfig.blockHight * 2),
                TextButton.icon(
                  onPressed: _handleImageUpload,
                  icon: const Icon(Icons.refresh),
                  label: Text(AppLocalizations.of(context).t('changeImage')),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).t('cancel')),
          ),
          ElevatedButton(
            onPressed: _isUploadingImage ? null : _save,
            child: Text(AppLocalizations.of(context).t('save')),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text(
        '${AppLocalizations.of(context).t('edit')} ${widget.field == 'name' ? AppLocalizations.of(context).t('name') : AppLocalizations.of(context).t('phoneNumber')}',
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.field == 'name'
                ? AppLocalizations.of(context).t('fullName')
                : AppLocalizations.of(context).t('phoneNumber'),
            hintText: widget.field == 'name'
                ? AppLocalizations.of(context).t('enterYourName')
                : AppLocalizations.of(context).t('enterPhoneNumber'),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (widget.field == 'name' && (value == null || value.isEmpty)) {
              return AppLocalizations.of(context).t('enterYourName');
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context).t('cancel')),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(AppLocalizations.of(context).t('save')),
        ),
      ],
    );
  }
}
