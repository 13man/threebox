/**
 * 全局上下文管理类
 * 用于在应用中共享数据
 */
export class GlobalContext {
  private static instance: GlobalContext;
  private context: Map<string, Object> = new Map();

  private constructor() {
  }

  /**
   * 获取单例实例
   */
  public static getInstance(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  /**
   * 设置上下文值
   * @param key 键
   * @param value 值
   */
  public setContext(key: string, value: Object): void {
    this.context.set(key, value);
  }

  /**
   * 获取上下文值
   * @param key 键
   * @returns 值
   */
  public getContext(key: string): Object | undefined {
    return this.context.get(key);
  }

  /**
   * 检查键是否存在
   * @param key 键
   * @returns 是否存在
   */
  public contains(key: string): boolean {
    return this.context.has(key);
  }

  /**
   * 删除上下文值
   * @param key 键
   * @returns 是否删除成功
   */
  public removeContext(key: string): boolean {
    return this.context.delete(key);
  }

  /**
   * 清空所有上下文
   */
  public clear(): void {
    this.context.clear();
  }
}