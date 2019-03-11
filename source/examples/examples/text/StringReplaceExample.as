package examples.text
{
	import examples.Example;

	/**
	 * 정규식 문자열 검출 예제
	 * @author SSen
	 */
	public class StringReplaceExample extends Example 
	{
		public function StringReplaceExample()
		{
			super();
			
			/**
			 * flag 
			 * g : global 전체 소스를 검색하게 된다
			 * i : ignoreCase 대소문자를 가리지 않게된다
			 * s : dotail \n 등의 내려쓰기도 검색하게 된다
			 * m : ^ 옵션이 붙었을때, 내려쓰기된 것을 검색한다
			 */
			var str1 : String = "\naaabbbcccaaabbbcccAAABBBCCC\naaabbbcccaaabbbcccAAABBBCCC";
			
			tracer("첫번째 소문자 bbb 만을 교체한다", "option : none", str1.replace(new RegExp("bbb", ""), "###"));
			tracer("모든 소문자 bbb 를 교체한다", "option : g", str1.replace(new RegExp("bbb", "g"), "###"));
			tracer("첫번째 bbb 를 교체한다", "option : i", str1.replace(new RegExp("bbb", "i"), "###"));
			tracer("모든 bbb 를 교체한다 (대소문자 무시)", "option : ig", str1.replace(new RegExp("bbb", "ig"), "###"));
			
			tracer("첫째줄의 aaa--BBB 를 교체한다", "option : s", str1.replace(new RegExp("aaa.*?BBB", "s"), "###"));
			tracer("모든줄의 aaa--BBB 를 교체한다", "option : sg", str1.replace(new RegExp("aaa.*?BBB", "sg"), "###"));
			tracer("sg 와 효과가 같다", "option : g", str1.replace(new RegExp("aaa.*?BBB", "g"), "###"));
			tracer("조금 이상하게 바뀐다 ###ccc###ccc###CCC\n###ccc###ccc###CCC \n대소문자 무시 효과가 적용되어서 aaabbb 를 검출교체 하는듯", "option : ig", str1.replace(new RegExp("aaa.*?BBB", "ig"), "###"));
			
			var str2 : String = "\n<a href='ccc'>aaa</a><a href='ccc'>bbb</a>\n<a href='ccc'>ccc</a>\n<a href='ccc'>aaa</a><a href='ccc'>bbb</a>\n<a href='ccc'>ccc</a>";
			tracer("첫번째 a 태그를 검출해서 보여준다", "option : none", str2.replace(new RegExp("<a(.*?)>(.*?)<\/a>", ""), "==$1==$2=="));
			tracer("모든 a 태그를 검출해서 보여준다", "option : g", str2.replace(new RegExp("<a(.*?)>(.*?)</a>", "g"), "==$1==$2=="));
			tracer("대소문자 무시 효과가 있지만 여기에서는 g 와 같다", "option : ig", str2.replace(new RegExp("<a(.*?)>(.*?)<\/a>", "ig"), "==$1==$2=="));
			
			tracer("^ 마크를 달았지만 아무런 효과가 없다", "option : none", str2.replace(new RegExp("^<a(.*?)>ccc<\/a>", ""), "==$1=="));
			tracer("^ 마크를 달고, m 옵션을 주면 내려쓰기된 줄의 문자를 검색 교체한다", "option : m", str2.replace(new RegExp("^<a(.*?)>ccc<\/a>", "m"), "==$1=="));
			
			tracer("첫번재 a 태그를 검출한다", "option : none", str2.match(new RegExp("<a(.*?)>(.*?)<\/a>", "")));
			tracer("모든 a 태그를 검출한다", "option : g", str2.match(new RegExp("<a(.*?)>(.*?)<\/a>", "g")));
			tracer("첫째줄엔 <a>aaa</a><a>ccc</a> 가 없으므로 검출되지 않는다", "option : none", str2.match(new RegExp("<a(.*?)>aaa<\/a>(.*?)<a(.*?)>ccc<\/a>", "")));
			tracer("?? 아무것도 나오질 않는다...;;;", "option : g", str2.match(new RegExp("<a(.*?)>aaa<\/a>(.*?)<a(.*?)>ccc<\/a>", "g")));
			tracer("내려쓰기를 무시한채로 <a>aaa</a><a>ccc</a> 를 검출해낸다", "option : s", str2.match(new RegExp("<a(.*?)>aaa<\/a>(.*?)<a(.*?)>ccc<\/a>", "s")));
			tracer("모든 내려쓰기를 무시한 <a>aaa</a><a>ccc</a> 를 검출해낸다", "option : sg", str2.match(new RegExp("<a(.*?)>aaa<\/a>(.*?)<a(.*?)>ccc<\/a>", "sg")));
		
			//TODO (.*?) 이 아닌 여러가지 그룹 예제를 만든다
			var str3 : String = "aaabbbcccdddeeefffaaacccdddeeefff";
			tracer("중간 제외는 검출이 되지 않는다", "aaa[^bbb]ccc", str3.match(new RegExp("aaa[^bbb]ccc", "g")));
			tracer("처음 검출은 된다", "[^bbb]ccc", str3.match(new RegExp("[^bbb]ccc", "g")));
			tracer("마지막 검출도 된다", "aaa[^bbb]", str3.match(new RegExp("aaa[^bbb]", "g")));
		}
	}
}
