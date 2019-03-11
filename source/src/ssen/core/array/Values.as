package ssen.core.array 
{
	import ssen.core.events.ValueEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;	
	use namespace flash_proxy;
	/**
	 * Array 나 Vector 보다 기능이 풍부함, 단 무거울수 있음
	 * @author SSen
	 */
	public dynamic class Values extends Proxy implements IEventDispatcher 
	{
		private var _dispatcher : EventDispatcher;
		private var _values : Dictionary;
		private var _names : Vector.<String>;

		
		/** 생성자 */
		public function Values()
		{
			_dispatcher = new EventDispatcher();
			_values = new Dictionary(true);
			_names = new Vector.<String>();
		}
		/* *********************************************************************
		 * sort
		 ********************************************************************* */
		/** index name 을 기준으로 정렬시킨다 */
		public function sortNames(desc : Boolean = false) : void 
		{
			var compareFunction : Function = (desc) ? VectorSortCompareFunctions.DESC_STRING : VectorSortCompareFunctions.ASC_STRING;
			_names.sort(compareFunction);
		}
		/* *********************************************************************
		 * clone
		 ********************************************************************* */
		/** 원본에서 index name 들에 해당하는 것들을 삭제하고, 삭제된 요소들을 반환한다 */ 
		public function splice(...names) : Values
		{
			var clone : Values = new Values();
			var name : String;
			var i : int;
			for (var f : int = 0;f < names.length; f++) {
				name = names[f];
				if (_values[name] != undefined) {
					clone[name] = _values[name];
					delete _values[name];
					i = _names.indexOf(name);
					if (i >= 0) {
						_names.splice(i, 1);
					}
				}
			}
			return clone;
		}
		/** index name 들에 해당하는 것들을 복사해서 반환한다 */
		public function copy(...names) : Values
		{
			var clone : Values = new Values();
			var name : String;
			for (var f : int = 0;f < names.length; f++) {
				name = names[f];
				if (_values[name] != undefined) {
					clone[name] = _values[name];
				}
			}
			return clone;
		}
		/** 동일한 Values 를 반환한다 */
		public function clone() : Values
		{
			var clone : Values = new Values();
			var f : int;
			for (f = 0;f < _names.length; f++) {
				clone[_names[f]] = _values[_names[f]];
			}
			return clone;
		}
		/* *********************************************************************
		 * push
		 ********************************************************************* */
		/** 홀수는 값이름:String, 짝수는 값:* 으로 값을 추가한다 */
		public function push(...properties) : void
		{
			var f : int;
			for (f = 0;f < properties.length; f += 2) {
				this[properties[f]] = properties[f + 1];
			}
		}
		/** for in 을 돌릴수 있는 모든 데이터 형식을 덧붙인다 */
		public function concat(obj : Object) : void
		{
			var name : String;
			for (name in obj) {
				this[name] = obj[name];
			}
		}
		/* *********************************************************************
		 * search informations
		 ********************************************************************* */
		/** 요소의 갯수 */
		public function get length() : int
		{
			return _names.length;
		}
		public function set length(length : int) : void
		{
			if (_names.length > length) {
				var out : Vector.<String> = _names.splice(length - 1, _names.length - length);
				var f : int;
				for (f = 0;f < out.length; f++) {
					delete _values[out[f]];
				}
			}
		}
		/** index 를 기준으로 name 을 가져온다 */
		public function getNameAt(index : int) : String
		{
			if (index > _names.length) {
				index = _names.length - 1;
			} else if (index < 0) {
				index = 0;
			}
			return _names[index];
		}
		/** name 을 기준으로 index 를 가져온다 */
		public function getIndexByName(name : String) : int
		{
			return _names.indexOf(name);
		}
		/** value 를 기준으로 index 들을 가져온다 */
		public function findIndexesByValue(value : *) : Vector.<int>
		{
			var vec : Vector.<int> = new Vector.<int>();
			var i : int;
			for (i = 0;i < _names.length; i++) {
				if (_values[_names[i]] === value) {
					vec.push(i);
				}
			}
			return vec;
		}
		/* *********************************************************************
		 * get changed type datas
		 ********************************************************************* */
		/** 데이터들을 node 에 attributes 로 붙여서 내보낸다 */
		public function getXMLAttributes(node : XML) : XML
		{
			var i : int;
			for (i = 0;i < _names.length; i++) {
				node["@" + _names[i]] = _values[_names[i]];
			}
			return node;
		}
		/** 데이터들을 XMLList 형식으로 내보낸다 */
		public function getXMLChildren() : XMLList
		{
			var i : int;
			var list : XML = <value />;
			for (i = 0;i < _names.length; i++) {
				list[_names[i]] = _values[_names[i]];
			}
			return list.*;
		}
		/** 데이터들을 XML 형식으로 내보낸다 */
		public function getXML() : XML
		{
			var xml : XML = <values />;
			xml.appendChild(getXMLChildren());
			return xml;
		}
		/* *********************************************************************
		 * override proxy
		 ********************************************************************* */
		/** @private */
		override flash_proxy function deleteProperty(name : *) : Boolean
		{
			if (!isNaN(Number(name))) name = getNameAt(Number(name));
			var n : String = String(name);
			if (_values[n] != undefined) {
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_DELETED, n));
				var i : int = _names.indexOf(n);
				_names.splice(i, 1);
				delete _values[n];
				return true;
			}
			return false;
		}
		/** @private */
		override flash_proxy function getProperty(name : *) : *
		{
			if (!isNaN(Number(name))) name = getNameAt(Number(name));
			var n : String = String(name);
			return _values[n];
		}
		/** @private */
		override flash_proxy function hasProperty(name : *) : Boolean
		{
			var id : String = String(name);
			return _values[id] != undefined;
		}
		/** @private */
		override flash_proxy function setProperty(name : *, value : *) : void
		{
			if (!isNaN(Number(name))) name = getNameAt(Number(name));
			var n : String = String(name);
			if (_values[n] == undefined) {
				_values[n] = value;
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_ADDED, n, value));
				_names.push(n);
			} else {
				_values[n] = value;
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGED, n, value));
			}
		}
		/** @private */
		override flash_proxy function nextName(index : int) : String
		{
			return _names[index - 1];
		}
		/** @private */ 
		override flash_proxy function nextNameIndex(index : int) : int
		{
			return (index >= _names.length) ? 0 : index + 1;
		}
		/** @private */
		override flash_proxy function nextValue(index : int) : *
		{
			return _values[nextName(index)];
		}
		/* *********************************************************************
		 * implement IEventDispatch
		 ********************************************************************* */
		/** EventDispatcher.dispatchEvent */
		public function dispatchEvent(event : Event) : Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		/** EventDispatcher.hasEventListener */
		public function hasEventListener(type : String) : Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		/** EventDispatcher.willTrigger */
		public function willTrigger(type : String) : Boolean
		{
			return _dispatcher.willTrigger(type);
		}
		/** EventDispatcher.removeEventListener */
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		/** EventDispatcher.addEventListener */
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		/* *********************************************************************
		 * information
		 ********************************************************************* */
		/** toString() */
		public function toString() : String
		{
			var attr : String = "";
			var f : int;
			for (f = 0;f < _names.length; f++) {
				attr += ' ' + _names[f] + ':' + getQualifiedClassName(_values[_names[f]]) + '="' + _values[_names[f]] + '"';
			}
			return '[Values' + attr + ']';
		}
	}
}
