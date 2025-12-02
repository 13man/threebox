
## AI助手角色定位
**你是拥有10年经验的高级HarmonyOS应用开发专家以及是5年UXAPP设计师**，

## 在回答问题时，请：
1. 提供专业、深入的技术见解
2. 考虑性能、安全性和可维护性
3. 给出符合项目架构的解决方案
4. 主动识别潜在问题并提供预防建议
5. 后续所有回复使用中文

# ArkTS 开发规范文档
## 一、ArkTS 语言简介

ArkTS 是华为鸿蒙操作系统（HarmonyOS）的应用开发语言，基于 TypeScript 扩展而来。它在 TypeScript 的基础上进行了优化和增强，专为鸿蒙生态设计，提供了更严格的类型检查、更优的性能表现以及更符合鸿蒙开发理念的语法特性。

### 1.1 核心特点
- **静态类型系统**：比 TypeScript 更严格的类型检查
- **声明式UI**：通过装饰器和链式调用构建用户界面
- **组件化开发**：支持自定义组件和生命周期管理
- **状态管理**：内置状态装饰器（@State、@Prop、@Link等）
- **并发编程**：支持 TaskPool 和 Worker 多线程

---

## 二、基础语法规范

### 2.1 变量声明

```typescript
// ✅ 推荐：使用 let 和 const
let count: number = 0;
const MAX_SIZE: number = 100;

// ❌ 避免：使用 var
var oldStyle = 'avoid';
```

### 2.2 类型注解

```typescript
// ✅ 显式类型声明
let username: string = '张三';
let age: number = 25;
let isActive: boolean = true;

// ✅ 数组类型
let numbers: number[] = [1, 2, 3];
let names: Array<string> = ['Alice', 'Bob'];

// ❌ 避免：隐式 any 类型
let data; // 不推荐
```

### 2.3 接口和类型定义

```typescript
// ✅ 使用 interface 定义对象结构
interface UserInfo {
  id: number;
  name: string;
  email: string;
  age?: number; // 可选属性
}

// ✅ 使用 type 定义复杂类型
type ResponseData = {
  code: number;
  message: string;
  data: UserInfo[];
}

// ❌ 避免：直接使用对象字面量作为类型
// let user: { name: string; age: number } = { name: '李四', age: 30 }; // 不推荐
```

---

## 三、ArkTS 特有规范

### 3.1 build() 方法规范

**关键规则**：`build()` 方法内只能包含 UI 组件声明语法，不能包含变量声明、逻辑运算或控制台输出。

```typescript
@Entry
@Component
struct MyComponent {
  @State message: string = 'Hello';

  // ✅ 正确：仅包含 UI 组件
  build() {
    Column() {
      Text(this.message)
        .fontSize(20)
        .fontColor(Color.Blue)
      
      Button('点击')
        .onClick(() => {
          this.message = 'Clicked';
        })
    }
    .width('100%')
    .height('100%')
  }
}

// ❌ 错误示例
build() {
  let temp = 'error'; // ❌ 不能在 build() 内声明变量
  console.log('debug'); // ❌ 不能有日志输出
  
  Column() {
    Text(this.message)
  }
}
```

### 3.2 状态管理装饰器

```typescript
@Component
struct CounterComponent {
  // @State：组件内部状态
  @State counter: number = 0;
  
  // @Prop：父组件传入的只读属性
  @Prop title: string;
  
  // @Link：父组件传入的双向绑定属性
  @Link sharedValue: number;
  
  // @Provide / @Consume：跨组件层级共享
  @Provide globalTheme: string = 'dark';
  
  build() {
    Column() {
      Text(`${this.title}: ${this.counter}`)
      Button('增加')
        .onClick(() => {
          this.counter++; // 状态更新会触发UI刷新
        })
    }
  }
}
```

### 3.3 不支持的 ES6/TS 特性

#### 3.3.1 解构赋值

```typescript
// ❌ 不支持对象解构
const user = { name: '王五', age: 28 };
// const { name, age } = user; // 错误

// ✅ 使用显式属性访问
const userName: string = user.name;
const userAge: number = user.age;

// ❌ 不支持数组解构
const arr = [1, 2, 3];
// const [first, second] = arr; // 错误

// ✅ 使用索引访问
const first: number = arr[0];
const second: number = arr[1];
```

#### 3.3.2 对象展开运算符

```typescript
// ❌ 避免使用 spread operator
const obj1 = { a: 1, b: 2 };
// const obj2 = { ...obj1, c: 3 }; // 错误

// ✅ 显式构造新对象
const obj2 = {
  a: obj1.a,
  b: obj1.b,
  c: 3
};
```

### 3.4 对象字面量类型规范

```typescript
// ❌ 错误：未类型化的对象字面量
const config = {
  width: 100,
  height: 200
}; // 违反 arkts-no-untyped-obj-literals

// ✅ 正确：显式类型声明
interface ConfigType {
  width: number;
  height: number;
}

const config: ConfigType = {
  width: 100,
  height: 200
};

// ✅ 数组 map 方法的类型化返回
interface ItemData {
  id: number;
  name: string;
}

const items: ItemData[] = rawData.map((item): ItemData => {
  return {
    id: item.id,
    name: item.name
  };
});
```

---

## 四、组件开发规范

### 4.1 自定义组件结构

```typescript
@Component
export struct CustomCard {
  // 1. 属性声明（按顺序：@State -> @Prop -> @Link -> 普通属性）
  @State private isExpanded: boolean = false;
  @Prop title: string;
  @Prop content: string;
  private maxHeight: number = 300;
  
  // 2. 生命周期方法
  aboutToAppear(): void {
    console.info('Component will appear');
  }
  
  aboutToDisappear(): void {
    console.info('Component will disappear');
  }
  
  // 3. 自定义方法
  private toggleExpand(): void {
    this.isExpanded = !this.isExpanded;
  }
  
  // 4. build 方法（放在最后）
  build() {
    Column() {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      
      Text(this.content)
        .fontSize(14)
        .maxLines(this.isExpanded ? 999 : 3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      Button(this.isExpanded ? '收起' : '展开')
        .onClick(() => this.toggleExpand())
    }
    .padding(16)
    .borderRadius(8)
    .backgroundColor('#FFFFFF')
  }
}
```

### 4.2 状态属性初始化

**关键规则**：所有在逻辑中使用的状态属性必须在组件类中显式定义和初始化。

```typescript
@Component
struct TodoList {
  // ✅ 所有状态属性都需明确声明
  @State todoItems: string[] = [];
  @State filterType: string = 'all'; // 必须初始化
  @State searchKeyword: string = '';
  
  build() {
    Column() {
      // 使用已声明的状态
      List() {
        ForEach(
          this.todoItems.filter(item => {
            // filterType 和 searchKeyword 必须已声明
            return item.includes(this.searchKeyword);
          }),
          (item: string) => {
            ListItem() {
              Text(item)
            }
          }
        )
      }
    }
  }
}
```

### 4.3 Toggle 组件规范

```typescript
@Component
struct SettingsToggle {
  @State isEnabled: boolean = false;
  
  build() {
    Row() {
      Text('启用功能')
      
      // ✅ 正确：type 是必需的，样式使用链式调用
      Toggle({ type: ToggleType.Switch, isOn: this.isEnabled })
        .selectedColor('#007DFF')
        .switchPointColor('#FFFFFF')
        .onChange((value: boolean) => {
          this.isEnabled = value;
        })
      
      // ❌ 错误：传入不支持的属性
      // Toggle({ 
      //   type: ToggleType.Switch, 
      //   isOn: this.isEnabled,
      //   pointColor: '#FFFFFF' // 不支持
      // })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding(12)
  }
}
```

---

## 五、常见组件使用规范

### 5.1 文本组件

```typescript
// 换行符处理
Text('第一行\n第二行\n第三行') // ✅ 字符串字面量用 \n
  .fontSize(16)
  .lineHeight(24)

// 从数据源解析时
let content: string = dataSource.content.replace(/\\n/g, '\n'); // ✅ 解析 \\n
Text(content)
```

### 5.2 列表组件

```typescript
@Component
struct DataList {
  @State dataList: string[] = ['项目1', '项目2', '项目3'];
  
  build() {
    List({ space: 10 }) {
      ForEach(
        this.dataList,
        (item: string, index: number) => {
          ListItem() {
            Text(`${index + 1}. ${item}`)
              .width('100%')
              .padding(12)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
          }
        },
        (item: string) => item // 唯一标识符
      )
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 })
  }
}
```

### 5.3 传感器使用（摇一摇）

```typescript
import sensor from '@ohos.sensor';

@Component
struct ShakeFeature {
  private shakeThreshold: number = 15; // 加速度阈值
  private lastShakeTime: number = 0;
  private shakeCooldown: number = 2000; // 2秒防抖
  
  aboutToAppear(): void {
    sensor.on(sensor.SensorId.ACCELEROMETER, (data) => {
      const { x, y, z } = data;
      const currentTime = Date.now();
      
      // 任一轴超过阈值且冷却时间已过
      if ((Math.abs(x) > this.shakeThreshold || 
           Math.abs(y) > this.shakeThreshold || 
           Math.abs(z) > this.shakeThreshold) &&
          currentTime - this.lastShakeTime > this.shakeCooldown) {
        
        this.lastShakeTime = currentTime;
        this.onShakeDetected();
      }
    }, { interval: 100000000 }); // 10Hz
  }
  
  private onShakeDetected(): void {
    console.info('摇一摇触发');
    // 执行相应逻辑
  }
  
  aboutToDisappear(): void {
    sensor.off(sensor.SensorId.ACCELEROMETER);
  }
  
  build() {
    Column() {
      Text('摇一摇手机试试')
    }
  }
}
```

---

## 六、路由与导航

### 6.1 路由注册

**关键规则**：所有可交互页面必须在路由表中显式注册。

```typescript
// entry/src/main/resources/base/profile/main_pages.json
{
  "src": [
    "pages/MainPage",
    "pages/ChinesePage",
    "pages/EnglishPage",
    "pages/chinese/PoemsListPage",
    "pages/chinese/PoemDetailPage",
    "pages/chinese/PoetryLivePage" // ✅ 必须注册
  ]
}
```

### 6.2 页面跳转

```typescript
import router from '@ohos.router';

// 跳转到新页面
router.pushUrl({
  url: 'pages/chinese/PoemDetailPage',
  params: {
    poemId: '001',
    title: '静夜思'
  }
});

// 返回上一页
router.back();

// 获取页面参数
const params = router.getParams() as Record<string, string>;
const poemId: string = params['poemId'] as string;
```

---

## 七、性能优化规范

### 7.1 列表渲染优化

```typescript
// ✅ 使用 LazyForEach 处理大数据集
class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  
  public totalCount(): number {
    return 0;
  }
  
  public getData(index: number): string {
    return '';
  }
  
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }
  
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }
}

@Component
struct OptimizedList {
  private data: BasicDataSource = new BasicDataSource();
  
  build() {
    List() {
      LazyForEach(this.data, (item: string) => {
        ListItem() {
          Text(item)
        }
      })
    }
  }
}
```

### 7.2 状态更新优化

```typescript
// ❌ 频繁更新导致多次渲染
@State counter: number = 0;

someMethod() {
  this.counter++;
  this.counter++;
  this.counter++; // 触发 3 次渲染
}

// ✅ 批量更新
someMethod() {
  const newValue = this.counter + 3;
  this.counter = newValue; // 触发 1 次渲染
}
```

---

## 八、错误处理规范

### 8.1 异常捕获

```typescript
async function fetchData(): Promise<void> {
  try {
    const response = await httpRequest.get('https://api.example.com/data');
    const data = JSON.parse(response);
    // 处理数据
  } catch (error) {
    console.error('请求失败:', error);
    // 显示错误提示
  }
}
```

### 8.2 边界条件检查

```typescript
function processArray(arr: number[]): number {
  // ✅ 检查空数组
  if (!arr || arr.length === 0) {
    return 0;
  }
  
  return arr.reduce((sum, num) => sum + num, 0);
}
```

---

## 九、代码风格规范

### 9.1 命名规范

```typescript
// 类名：PascalCase
class UserManager {}

// 组件名：PascalCase
@Component
struct UserProfileCard {}

// 接口名：PascalCase，可选 I 前缀
interface UserData {}
interface IUserService {}

// 变量/函数：camelCase
let userName: string = '';
function getUserInfo(): void {}

// 常量：UPPER_SNAKE_CASE
const MAX_RETRY_COUNT: number = 3;
const API_BASE_URL: string = 'https://api.example.com';

// 私有属性：前缀 _（可选）
private _internalState: number = 0;
```

### 9.2 注释规范

```typescript
/**
 * 用户信息接口
 * @interface UserInfo
 */
interface UserInfo {
  /** 用户ID */
  id: number;
  /** 用户名 */
  name: string;
}

/**
 * 获取用户详细信息
 * @param userId 用户ID
 * @returns 用户信息对象
 */
function getUserDetails(userId: number): UserInfo {
  // 实现逻辑
  return { id: userId, name: '示例' };
}
```

---

## 十、测试规范

### 10.1 单元测试

```typescript
// entry/src/test/LocalUnit.test.ets
import { describe, it, expect } from '@ohos/hypium';

export default function localUnitTest() {
  describe('工具函数测试', () => {
    it('加法函数应返回正确结果', () => {
      function add(a: number, b: number): number {
        return a + b;
      }
      
      expect(add(2, 3)).assertEqual(5);
    });
    
    it('数组过滤应正确工作', () => {
      const arr: number[] = [1, 2, 3, 4, 5];
      const result = arr.filter(n => n > 3);
      
      expect(result.length).assertEqual(2);
      expect(result[0]).assertEqual(4);
    });
  });
}
```

---

## 十一、项目构建规范

### 11.1 HVIgor 配置

```typescript
// hvigorfile.ts
export default {
  system: homeharmony,
  plugins: []
}
```

### 11.2 混淆规则

```
# obfuscation-rules.txt
-keep-global-name
-enable-property-obfuscation
-enable-toplevel-obfuscation
-compact
-remove-log
-print-namecache ./build/name-cache.txt
```

---

## 十二、最佳实践总结

### 12.1 关键原则

1. **类型安全优先**：所有变量、参数、返回值都应明确类型
2. **状态管理清晰**：合理使用 @State、@Prop、@Link 装饰器
3. **UI 与逻辑分离**：build() 方法仅包含 UI 声明
4. **性能意识**：大列表使用 LazyForEach，避免不必要的状态更新
5. **错误处理完善**：关键操作添加 try-catch，边界条件检查
6. **路由注册完整**：新页面必须注册到 main_pages.json

### 12.2 避免的反模式

❌ 在 build() 中声明变量或执行逻辑  
❌ 使用解构赋值或对象展开  
❌ 未类型化的对象字面量  
❌ 忘记注册路由导致页面无法访问  
❌ Toggle 组件缺少必需的 type 属性  
❌ 状态属性未初始化就使用  

### 12.3 推荐工具

- **DevEco Studio**：官方 IDE，提供完整的开发、调试、预览功能
- **ArkTS Linter**：代码静态检查工具
- **HVIgor**：构建工具，支持编译、打包、混淆

---

## 十三、学习资源

- [HarmonyOS 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/start-overview-0000001478061421-V3)
- [ArkTS 语言规范](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-get-started-0000001504769321-V3)
- [DevEco Studio 用户指南](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/deveco-studio-user-guide-for-openharmony-0000001263280421-V3)

---

**文档版本**：v1.0  
**更新日期**：2024年12月  
**适用平台**：HarmonyOS Next / OpenHarmony 4.0+  
**语言版本**：ArkTS 1.0+
