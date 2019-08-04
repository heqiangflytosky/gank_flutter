import 'GankItemBean.dart';

class GankItem {

}

class GankContentItem extends GankItem{
  GankItemBean data;
  GankContentItem(GankItemBean bean) {
    data = bean;
  }
  //GankItemBean get gankData => this.data;
}

class GankHeaderItem extends GankItem {
  GankHeaderItem(String title, String url) {
    this.title = title;
    this.imageUrl = url;
  }
  String title;
  String imageUrl;
}

class GankImageItem extends GankItem {
  String imageUrl;
  GankImageItem(String url) {
    imageUrl = url;
  }
}