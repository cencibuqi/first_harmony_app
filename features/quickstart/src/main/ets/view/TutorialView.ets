import { ArticleClass } from '../model/ArticalClass';
import { bufferToString } from '../util/BufferUtil';

// @Preview
@Component
struct TutorialItem {
  private title: string = "Step1 快速入门介绍"
  private brief: string = "本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序 。"
  @Prop tutorialItem: ArticleClass;

  build() {
    Row() {
      Column() {
        Text(this.tutorialItem.title)
          .height(19)
          .width('100%')
          .fontSize(14)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })
        Text(this.tutorialItem.brief)
          .height(32)
          .width('100%')
          .fontSize(12)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .fontWeight(400)
          .fontColor('rgba(0,0,0,0.6)')
          .margin({ top: 5 })
      }
      // 表示它们在任意尺寸的设备下自适应占满剩余空间
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start) // 内部子组件向左对齐
      .margin({ right: 12 })

      Image($r(this.tutorialItem.imageSrc))
        .height(64)
        .width(108)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top) // 内部容器顶端对齐
  }
}

@Preview
@Component
export struct TutorialView {
  @State tutorialList: Array<ArticleClass> = []

  aboutToAppear(): void {
    this.getTutorialDataFromJSON();
  }

  getTutorialDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('TutorialData.json').then(value => {
      this.tutorialList = JSON.parse(bufferToString(value.buffer)) as ArticleClass[];
    })
  }

  build() {
    Column() {
      Text('入门教程')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })
      List({ space: 12 }) {
        ForEach(this.tutorialList, (item: ArticleClass) => {
          ListItem() {
            TutorialItem({ tutorialItem: item })
          }
        }, (item: ArticleClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}