import 'package:flutter/material.dart';
import '../../widgets/actions/bla_button.dart';
import '../../theme/theme.dart';

// Test screen to display all of BlaButton
class ButtonTestScreen extends StatelessWidget {
  const ButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlaButton Test'),
        backgroundColor: BlaColors.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(BlaSpacings.l),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Primary Buttons'),
              _buildButtonExample(
                'Primary Button',
                BlaButton(
                  text: 'Primary Button',
                  onPressed: () {},
                ),
              ),
              _buildButtonExample(
                'Primary with Icon',
                BlaButton(
                  text: 'Primary with Icon',
                  icon: Icons.search,
                  onPressed: () {},
                ),
              ),
              _buildButtonExample(
                'Primary Disabled',
                BlaButton(
                  text: 'Primary Disabled',
                  isEnabled: false,
                ),
              ),
              _buildButtonExample(
                'Primary Custom Size',
                BlaButton(
                  text: 'Custom Size',
                  width: 200,
                  height: 60,
                  onPressed: () {},
                ),
              ),
              
              SizedBox(height: BlaSpacings.l),
              _buildSectionTitle('Secondary Buttons'),
              _buildButtonExample(
                'Secondary Button',
                BlaButton(
                  text: 'Secondary Button',
                  isPrimary: false,
                  onPressed: () {},
                ),
              ),
              _buildButtonExample(
                'Secondary with Icon',
                BlaButton(
                  text: 'Secondary with Icon',
                  isPrimary: false,
                  icon: Icons.favorite,
                  onPressed: () {},
                ),
              ),
              _buildButtonExample(
                'Secondary Disabled',
                BlaButton(
                  text: 'Secondary Disabled',
                  isPrimary: false,
                  isEnabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: BlaSpacings.m),
      child: Text(
        title,
        style: BlaTextStyles.heading.copyWith(fontSize: 20),
      ),
    );
  }

  Widget _buildButtonExample(String title, Widget button) {
    return Padding(
      padding: EdgeInsets.only(bottom: BlaSpacings.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: BlaSpacings.s),
            child: Text(title, style: BlaTextStyles.body),
          ),
          button,
          SizedBox(height: BlaSpacings.s),
        ],
      ),
    );
  }
}