package com.bnu.card.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.commons.beanutils.Converter;

/**
 *
 * @author lucas
 */
public class DateConvert implements Converter {

    public Object convert(Class arg0, Object arg1) {
    	System.out.println("arg1:" + arg1);
    	if(arg1 == null){
    		arg1 = "";
    	}else{
    		if(arg1.getClass().equals(String.class)){
    			if(arg1.toString().indexOf(':')<0)
    				arg1 = arg1.toString() + " 00:00:00";
    		}else if(arg0.equals(java.util.Date.class)){
    			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    			arg1 = df.format(arg1);
    		}else if(arg0.equals(java.sql.Date.class)){
    			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    			arg1 = df.format(arg1);
    		}else if(arg0.equals(java.sql.Timestamp.class)){
    			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    			arg1 = df.format(arg1);
    		}
    		else
    			arg1 = arg1.toString();
    	}
    	
    	String p = (String)arg1;
        if(p== null || p.trim().length()==0){
            return null;
        }   
        try{
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return df.parse(p.trim());
        }
        catch(Exception e){
            try {
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                return df.parse(p.trim());
            } catch (ParseException ex) {
                return null;
            }
        }
        
    }

}