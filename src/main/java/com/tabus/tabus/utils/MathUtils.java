package com.tabus.tabus.utils;

import java.util.List;

/**
 * 数学工具类，提供常用的统计计算方法
 * 包括平均值、标准差和皮尔逊相关系数的计算
 * 
 * @author SuperMrX
 */
public class MathUtils {

    /**
     * 计算给定数值列表的平均值
     * 
     * @param values 数值列表
     * @return 平均值，如果列表为空则返回0
     */
    public static double calculateMean(List<Double> values) {
        if (values == null || values.isEmpty()) {
            return 0.0;
        }
        return values.stream().mapToDouble(Double::doubleValue).average().orElse(0);
    }

    /**
     * 计算给定数值列表的标准差
     * 
     * @param values 数值列表
     * @param mean 平均值
     * @return 标准差，如果列表为空则返回0
     */
    public static double calculateStandardDeviation(List<Double> values, double mean) {
        if (values == null || values.isEmpty()) {
            return 0.0;
        }
        double variance = values.stream()
                .mapToDouble(v -> Math.pow(v - mean, 2))
                .average()
                .orElse(0);
        return Math.sqrt(variance);
    }

    /**
     * 计算两个数值列表的皮尔逊相关系数
     * 
     * @param x 第一个数值列表
     * @param y 第二个数值列表
     * @return 皮尔逊相关系数，如果列表为空或长度不一致则返回0
     */
    public static double calculatePearsonCorrelation(List<Double> x, List<Double> y) {
        if (x == null || y == null || x.size() != y.size() || x.size() == 0) {
            return 0;
        }
        
        int n = x.size();
        
        double sumX = x.stream().mapToDouble(Double::doubleValue).sum();
        double sumY = y.stream().mapToDouble(Double::doubleValue).sum();
        
        double sumXSq = x.stream().mapToDouble(v -> Math.pow(v, 2)).sum();
        double sumYSq = y.stream().mapToDouble(v -> Math.pow(v, 2)).sum();
        
        double sumXY = 0;
        for (int i = 0; i < n; i++) {
            sumXY += x.get(i) * y.get(i);
        }
        
        double numerator = sumXY - (sumX * sumY / n);
        double denominator = Math.sqrt(
                (sumXSq - Math.pow(sumX, 2) / n) * 
                (sumYSq - Math.pow(sumY, 2) / n)
        );
        
        if (denominator == 0) {
            return 0;
        }
        
        return numerator / denominator;
    }
}