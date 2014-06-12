package com.test.util;

/**
 * 数字短语转换为莫尔斯码
 *
 */


public class MorseCode {

	public static String[] CODE_LONG = {
		"11111",//0
		"01111",
		"00111",
		"00011",
		"00001",
		"00000",
		"10000",
		"11000",
		"11100",
		"11110",//9
	};
	public static String[] CODE_SHORT = {
		"1",//0
		"01",
		"001",
		"0001",
		"00001",//4
		"00000",
		"10000",
		"11000",
		"100",
		"10",//9
	};
	
	public static char[] NUMBER_CODE = {
		'0',
		'1',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
	};	
	//间隔时间：滴，1t；答，3t；滴答间，1t；字母间，3t；字间，5t。
	
	public static String getLCode(String s){
		String ret = "";
		
		if(s!=null&&s.length()>0){
			char[] ss = s.toCharArray();
			for (int i = 0; i < ss.length; i++) {
				char c = ss[i];
				if(c>=NUMBER_CODE[0] && c<=NUMBER_CODE[9])
					ret += CODE_LONG[Integer.parseInt(c+"")]+",";
			}
		}
		
		return ret;
	}
	
	public static String getSCode(String s){
		String ret = "";
		
		if(s!=null&&s.length()>0){
			char[] ss = s.toCharArray();
			for (int i = 0; i < ss.length; i++) {
				char c = ss[i];
				if(c>=NUMBER_CODE[0] && c<=NUMBER_CODE[9])
					ret += CODE_SHORT[Integer.parseInt(c+"")]+",";
			}
		}
		
		return ret;
	}
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(getLCode("520"));
		System.out.println(getSCode("520"));
	}
}
