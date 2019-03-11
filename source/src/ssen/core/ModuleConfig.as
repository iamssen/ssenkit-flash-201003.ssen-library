package ssen.core 
{
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ModuleConfig implements IModuleConfig 
	{
		public var data : Object;
		public function ModuleConfig(data : Object) 
		{
			this.data = data;
		}
	}
}
