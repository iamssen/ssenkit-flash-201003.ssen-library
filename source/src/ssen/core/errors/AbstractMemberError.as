package ssen.core.errors
{
	/**
	 * Abstract member 에러
	 * @author SSen
	 */
	public class AbstractMemberError extends Error 
	{
		public function AbstractMemberError()
		{
			super("abstract member 입니다.", 0);
		}
	}
}
