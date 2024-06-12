package com.platform.modules.loan.utils;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

public class StringUtils {

    static Random random = new Random();
    static char[] str = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
            't', 'u', 'v', 'w', 'x', 'y', 'z'};
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.US);
    private static long startVaue = 0;

    public static synchronized String getBillno() {
        SimpleDateFormat oFormat;
        startVaue++;
        startVaue = startVaue % 1000;
        java.text.DecimalFormat format = new java.text.DecimalFormat("000");
        String sStartVaue = format.format(startVaue);
        Date oToday = new Date();
        oFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String sDate = oFormat.format(oToday);
        String id = sDate + sStartVaue;
        return id;
    }
}
