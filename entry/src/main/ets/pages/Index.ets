import { Banner } from '../view/Banner';
import { EnablementView } from '../view/EnablementView';
import { TutorialView } from '../view/TutorialView';

// @Entry装饰的@Component将作为UI页面的入口。在单个UI页面中，最多可以使用@Entry装饰一个自定义组件。
@Entry
  // @Component装饰后具备组件化的能力
@Component
struct Index {
  // @State 装饰器装饰的状态变量
  @State message: string = '快速入门';

  build() {
    Column() {
      Text(this.message)
        .id('quickStart')// 组件标识id用于唯一指定组件。
        .fontSize(24)// 字体大小
        .fontWeight(700)// 字体粗细
        .width('100%')// 宽度
        .textAlign(TextAlign.Start)// 文本对齐
        .padding({ left: 16 })// 内边距
        .fontFamily('HarmonyHeiTi-Bold')// 字体
        .lineHeight(33) // 行高
      Scroll() {
        Column() {
          Banner()
          EnablementView()
          TutorialView()
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
    }
    .height('100.00%') // 高度
    .width('100%')
    .backgroundColor('#F1F3F5') // 背景色
  }
}