import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

/// News Screen
class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hot Topics
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.hotTopics,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildHotTopicCard(context, 'Topic ${index + 1}'),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // News List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Latest News',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildNewsItem(context, 'News Title ${index + 1}');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHotTopicCard(BuildContext context, String title) {
    return Card(
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image),
          ),
          title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: const Text('२ घन्टा अघि'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // News detail page खोलने
          },
        ),
      ),
    );
  }
}
