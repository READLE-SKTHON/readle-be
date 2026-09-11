package com.readle.readlebackend.global.util;

/**
 * 임베딩 벡터(double[]) 관련 계산 유틸.
 */
public final class VectorUtils {

    private VectorUtils() {
    }

    /**
     * 두 벡터 사이의 코사인 유사도를 계산한다 (-1.0 ~ 1.0).
     * 두 벡터의 차원이 다르거나, null이거나, 크기가 0인 벡터(zero vector)가 있으면 0.0을 반환한다.
     */
    public static double cosineSimilarity(double[] a, double[] b) {
        if (a == null || b == null || a.length != b.length || a.length == 0) {
            return 0.0;
        }

        double dot = 0.0;
        double normA = 0.0;
        double normB = 0.0;
        for (int i = 0; i < a.length; i++) {
            dot += a[i] * b[i];
            normA += a[i] * a[i];
            normB += b[i] * b[i];
        }

        if (normA == 0.0 || normB == 0.0) {
            return 0.0;
        }

        return dot / (Math.sqrt(normA) * Math.sqrt(normB));
    }
}
