package com.ja.webproject.commons;

import java.security.*;

public class MessageDigestUtil {

	public static String getPasswordHashCode(String password) {
		password = password + "@webproject";//해킹 사전법 방지위해서 "@webproject"같은 문자열 추가해줌

		String hashCode = null;

		StringBuilder sb = new StringBuilder();
		
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");

			messageDigest.reset();
			messageDigest.update(password.getBytes("UTF-8"));

			byte[] chars = messageDigest.digest();

			//20byte(40)글자 길이 맞추기위한 과정 
			for (int i = 0; i < chars.length; i++) {
				String tmp = Integer.toHexString(0xff & chars[i]);
				if (tmp.length() == 1)
					sb.append("0");
				sb.append(tmp);
			}

			hashCode = sb.toString();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return hashCode;

	}
}