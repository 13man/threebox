/**
 * 全局上下文，用于在应用中共享数据
 */
export class GlobalContext {
  private static instance: GlobalContext;
  private context: Map<string, Object> = new Map();

  private constructor() {
  }

  /**
   * 获取GlobalContext单例实例
   */
  public static getInstance(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  /**
   * 设置全局上下文对象
   */
  public setContext(key: string, value: Object): void {
    this.context.set(key, value);
  }

  /**
   * 获取全局上下文对象
   */
  public getContext(key: string): Object | undefined {
    return this.context.get(key);
  }

  /**
   * 删除全局上下文对象
   */
  public removeContext(key: string): boolean {
    return this.context.delete(key);
  }

  /**
   * 清空所有全局上下文对象
   */
  public clearContext(): void {
    this.context.clear();
  }
}