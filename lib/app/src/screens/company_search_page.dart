import 'package:flutter/material.dart';
import 'package:joistictask/app/src/controllers/company_controllers.dart';

class CompanySearch extends SearchDelegate {
  final CompanyController companyController;

  CompanySearch(this.companyController);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var searchResults = companyController.companyList
        .where((company) => company['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var company = searchResults[index];
        String title = company['title'].toString().split(" ").take(2).join(" ");
        String description = company['title'].toString().split(" ").take(5).join(" ");

        return ListTile(
          leading: Image.network(company['thumbnailUrl'], width: 50, height: 50),
          title: Text(title),
          subtitle: Text(description),
          trailing: Icon(Icons.circle, color: Colors.purple),
          onTap: () => companyController.fetchCompanies(), // Show bottom sheet here
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
