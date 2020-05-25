import 'package:flutter/material.dart';
import 'package:station_locator/configurations/themeData.dart';


class SearchView extends StatelessWidget {
final searchController;

  SearchView(this.searchController);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:paddingNormal),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.09),
        borderRadius: BorderRadius.all(Radius.circular(paddingHalf)),
      ),
      child: TextField(
maxLines: 1,
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.black26,
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () => searchController.clear(),
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black45,
                  ),
                )
              : null,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.black45),
          fillColor: Colors.black45,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
