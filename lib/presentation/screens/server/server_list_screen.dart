import 'package:flutter/material.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/data/model/server_model.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key, required this.servers});

  final List<ServerModel> servers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servers')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: PaddingDefault.large),
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: server.isActive ? AppColors.primary : Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    server.name ?? 'Unknown',
                    style: AppTypography.poppins_14px_w600.withColor(
                      server.isActive ? AppColors.primary : Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Text('#${server.id}', style: AppTypography.poppins_14px_w600),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
