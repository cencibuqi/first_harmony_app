import { BannerClass } from '../model/BannerClass'
import { bufferToString } from '../util/BufferUtil';

// @Preview装饰器装饰，以便单独预览组件
// @Preview
@Component
export struct Banner {
  @State bannerList: Array<BannerClass> = []

  // 在创建自定义组件的新实例后，在执行其build()函数之前执行
  aboutToAppear(): void {
    this.getBannerDataFromJSON();
  }

  getBannerDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
      // 获取buffer内容
      let buffer: ArrayBufferLike = value.buffer;
      // 转换为字符串
      let res: string =  bufferToString(buffer);
      // 解析为数据结构
      this.bannerList = JSON.parse(res) as BannerClass[];
    })
  }

  build() {
    Swiper() {
      // ArkUI提供了Image组件用于显示图片
      // 使用$r('app.media. 文件名字')的方式将media文件夹下的图片读取到Image组件内
      // Image($r('app.media.banner_pic1'))// 设置图片的填充效果为Contain模式，即保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内
      //   .objectFit(ImageFit.Contain)
      //   .width('100%')
      //   .padding({
      //     left: 16,
      //     right: 16,
      //     top: 11
      //   })
      //   .borderRadius(16) // 圆角值

      // ForEach循环渲染的第一个参数是一个任意类型的数组arr
      // ForEach循环渲染的第二个参数itemGenerator，这一部分本质上其实就是一个函数，该函数会按序取到数组中的每一个项，生成函数体中的组件。
      // ForEach的第三个参数是keyGenerator，这个部分本质上也是一个函数，这个函数关键的作用就在于通过标识每一个实际的组件
      ForEach(this.bannerList, (item: BannerClass, index: number) => {
        Image($r(item.imageSrc))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({
            left: 16,
            right: 16,
            top: 11
          })
          .borderRadius(16)
      }, (item: BannerClass, index: number) => item.id);
    }
    .autoPlay(true) // autoPlay控制是否自动轮播子组件
    .loop(true) // loop属性控制是否循环播放
    .indicator( // indicator属性自定义导航点的位置和样式
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#')
    )
  }
}