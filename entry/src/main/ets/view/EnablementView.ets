import { ArticleClass } from '../model/ArticalClass';
import { bufferToString } from '../util/BufferUtil';

// @Preview
@Component
struct EnablementItem {
  // private title: string = "HarmonyOS第一课"
  // private brief: string = "基于真实的开发场景，提供向导式学习，多维度融合课程等内容，给开发者提供全新的学习体验"
  @Prop enablementItem: ArticleClass;

  build() {
    Column() {
      Image($r(this.enablementItem.imageSrc))
        .width('100%')
        .objectFit(ImageFit.Contain)
        .height(96)
        .borderRadius({
          topLeft: 16,
          topRight: 16
        })
      Text(this.enablementItem.title)
        .height(19)
        .width('100%')
        .fontSize(14)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .fontWeight(400)
        .padding({ left: 12, right: 12 })
        .margin({ top: 8 })
      Text(this.enablementItem.brief)
        .height(32)
        .width('100%')
        .fontSize(12)
        .textAlign(TextAlign.Start)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(2)
        .fontWeight(400)
        .fontColor('rgba(0,0,0,0.6)')
        .padding({ left: 12, right: 12 })
        .margin({ top: 2 })
    }
    .width(160)
    .height(169)
    .borderRadius(16)
    .backgroundColor(Color.White)
  }
}

// @Preview
@Component
export struct EnablementView {
  @State enablementList: Array<ArticleClass> = [];

  aboutToAppear(): void {
    this.getEnablementDataFromJSON();
  }

  getEnablementDataFromJSON(){
    getContext(this).resourceManager.getRawFileContent('EnablementData.json').then(value => {
      this.enablementList = JSON.parse(bufferToString(value.buffer)) as ArticleClass[];
    })
  }

  build() {
    Column() {
      Text('赋能套件')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })
      Grid() {
        ForEach(this.enablementList, (item: ArticleClass) => {
          // 将EnablementItem作为GridItem的子组件，
          // 并将enablementList每一项的内容作为参数传递给EnablementItem组件进行渲染
          GridItem() {
            EnablementItem({ enablementItem: item })
          }
        }, (item: ArticleClass) => item.id)
      }
      // rowsTemplate和columnsTemplate属性值是一个由多个空格和'数字+fr'间隔拼接的字符串，
      // fr的个数即网格布局的行或列数，fr前面的数值大小，用于计算该行或列在网格布局宽度上的占比
      .rowsTemplate('1fr')
      .columnsGap(8)
      .scrollBar(BarState.Off) // 关闭滚动条
      .height(169)
      .padding({ top: 2, left: 16, right: 16 })
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}