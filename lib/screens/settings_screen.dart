import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _elderlyModeEnabled = false;
  bool _accessibilityColorsEnabled = false;
  bool _smallWindowPlayEnabled = true;
  bool _shareAfterScreenshotEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          title: const Text('设置'),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline, size: 24),
              onPressed: () {
                // 帮助按钮点击事件
              },
            ),
          ],
          titleTextStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      ),
      body: Column(
          children: [
            // AppBar下方的分割线
            Container(
              height: 1,
              color: Colors.grey[100],
            ),
            Expanded(
              child: ListView(
                children: [
                  // 界面设置分组
                  _buildSettingsSection([
                    _buildSettingItem('默认首页设置', '首页', () {}),
                    _buildSettingItem('设置皮肤', '白色', () {}),
                    _buildSwitchSettingItem('长辈版', _elderlyModeEnabled, (value) {
                      setState(() {
                        _elderlyModeEnabled = value;
                      });
                    }),
                    _buildSwitchSettingItem(
                      '无障碍配色',
                      _accessibilityColorsEnabled,
                      (value) {
                        setState(() {
                          _accessibilityColorsEnabled = value;
                        });
                      },
                      showInfo: true,
                    ),
                  ]),

                  // 行情设置分组
                  _buildSettingsSection([
                    _buildSettingItem('行情刷新频率', '实时', () {}),
                    _buildSettingItem('行情价格闪烁', '关闭', () {}),
                    _buildSettingItem('K线设置', '', () {}),
                    _buildSettingItem('自选股设置', '', () {}),
                  ]),

                  // 功能设置分组
                  _buildSettingsSection([
                    _buildSwitchSettingItem('小窗播放设置', _smallWindowPlayEnabled, (value) {
                      setState(() {
                        _smallWindowPlayEnabled = value;
                      });
                    }, isActive: true),
                    _buildSwitchSettingItem(
                      '截图后分享',
                      _shareAfterScreenshotEnabled,
                      (value) {
                        setState(() {
                          _shareAfterScreenshotEnabled = value;
                        });
                      },
                      isActive: true,
                    ),
                    _buildSettingItem('站内信设置', '', () {}),
                  ]),

                  // 其他设置分组
                  _buildSettingsSection([
                    _buildSettingItem('应用权限设置', '', () {}),
                    _buildSettingItem('个性化推荐设置', '', () {}),
                  ]),
                ],
              ),
            ),
          ],
        ),
    );
  }

  // 构建设置项分组
  Widget _buildSettingsSection(List<Widget> children) {
    return Column(
      children: children,
    );
  }

  // 构建普通设置项
  Widget _buildSettingItem(String title, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[100]!, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Row(
              children: [
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, size: 18, color: Colors.grey[400]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建带开关的设置项
  Widget _buildSwitchSettingItem(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
    {bool showInfo = false, bool isActive = false}) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              if (showInfo)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.info_outline, size: 16, color: Colors.amber),
                ),
            ],
          ),
          // 自定义开关样式使其更接近设计图
          GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: 52,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isActive 
                    ? (value ? const Color(0xFFF5D7B2) : Colors.grey[300]!)
                    : Colors.grey[300]!,
              ),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value 
                      ? (isActive ? const Color(0xFFE69647) : Colors.grey[400]!)
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}