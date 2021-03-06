import La
import Accelerate

extension Double: Field {
    public static let zero: Double = 0

    public static func matrix_identity<M, N>() -> Matrix<M, N, Double> {
        var entries = Array<Double>(repeating: 0, count: Int(M.value * N.value))
        (0..<M.value)
            .lazy
            .map { Int(($0 * N.value) + $0) }
            .forEach { entries[$0] = 1; return }
        return Matrix.create(entries)!
    }

    public static func matrix_additiveInvese<M, N>(of a: Matrix<M, N, Double>) -> Matrix<M, N, Double> {
        return matrix_scalar(a, -1)
    }

    public static func matrix_add<M, N>(_ a: Matrix<M, N, Double>, _ b : Matrix<M, N, Double>) -> Matrix<M, N, Double> {
        var entries = a.entries
        cblas_daxpy(M.value * N.value, 1.0, b.entries, 1, &entries, 1)
        return Matrix.create(entries)!
    }

    public static func matrix_subtract<M, N>(_ a: Matrix<M, N, Double>, _ b: Matrix<M, N, Double>) -> Matrix<M, N, Double> {
        var entries = a.entries
        cblas_daxpy(M.value * N.value, -1.0, b.entries, 1, &entries, 1)
        return Matrix.create(entries)!
    }

    public static func matrix_scalar<M, N>(_ b: Matrix<M, N, Double>, _ a: Double) -> Matrix<M, N, Double> {
        var entries = Array<Double>(repeating: 0, count: Int(M.value * N.value))
        cblas_daxpy(M.value * N.value, a, b.entries, 1, &entries, 1)
        return Matrix.create(entries)!
    }

    public static func matrix_multiply<M, N, P>(_ a: Matrix<M, N, Double>, _ b: Matrix<N, P, Double>) -> Matrix<M, P, Double> {
        var entries = Array<Double>(repeating: 0, count: Int(M.value * P.value))
        cblas_dgemm(
            CblasRowMajor,
            CblasNoTrans,
            CblasNoTrans,
            M.value,
            P.value,
            N.value,
            1.0,
            a.entries,
            N.value,
            b.entries,
            P.value,
            0.0,
            &entries,
            P.value
        )
        return Matrix.create(entries)!
    }

    public static func matrix_transpose<M, N>(_ a: Matrix<M, N, Double>) -> Matrix<N, M, Double> {
        var entries = Array<Double>(repeating: 0, count: Int(N.value * M.value))
        cblas_dgemm(
            CblasRowMajor,
            CblasTrans,
            CblasNoTrans,
            N.value,
            M.value,
            M.value,
            1.0,
            a.entries,
            N.value,
            Matrix<M, M, Double>.identity().entries,
            M.value,
            0.0,
            &entries,
            M.value
        )
        return Matrix.create(entries)!
    }
}
