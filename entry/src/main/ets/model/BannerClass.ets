export class BannerClass {
  id: string = "";
  // ResourceStr类型，为Resource类型与string类型的联合类型。
  // Resource类型在加载本地图片资源时会用到的，而string类型在加载网络图片资源时会用到。
  imageSrc: string = "";
  url: string = "";

  constructor(id: string, imageSrc: string, url: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.url = url;
  }
}