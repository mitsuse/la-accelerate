import La
import Accelerate

extension Float: Field {
    public static let zero: Float = 0

    public static func matrix_identity<M, N>() -> Matrix<M, N, Float> {
        var entries = Array<Float>(repeating: 0, count: Int(M.value * N.value))
        (0..<M.value)
            .lazy
            .map { Int(($0 * N.value) + $0) }
            .forEach { entries[$0] = 1; return }
        return Matrix.create(entries)!
    }

    public static func matrix_additiveInvese<M, N>(of a: Matrix<M, N, Float>) -> Matrix<M, N, Float> {
        return matrix_scalar(a, -1)
    }

    public static func matrix_add<M, N>(_ a: Matrix<M, N, Float>, _ b : Matrix<M, N, Float>) -> Matrix<M, N, Float> {
        var entries = a.entries
        cblas_saxpy(M.value * N.value, 1.0, b.entries, 1, &entries, 1)
        return Matrix.create(entries)!
    }

    public static func matrix_subtract<M, N>(_ a: Matrix<M, N, Float>, _ b: Matrix<M, N, Float>) -> Matrix<M, N, Float> {
        var entries = a.entries
        cblas_saxpy(M.value * N.value, -1.0, b.entries, 1, &entries, 1)
        return Matrix.create(entries)!
    }

    public static func matrix_scalar<M, N>(_ b: Matrix<M, N, Float>, _ a: Float) -> Matrix<M, N, Float> {
        var entries = Array<Float>(repeating: 0, count: Int(M.value * N.value))
        cblas_saxpy(M.value * N.value, a, b.entries, 1, &entries, 1)
        return Matrix.create(entries)!
    }

    public static func matrix_multiply<M, N, P>(_ a: Matrix<M, N, Float>, _ b: Matrix<N, P, Float>) -> Matrix<M, P, Float> {
        var entries = Array<Float>(repeating: 0, count: Int(M.value * P.value))
        cblas_sgemm(
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

    public static func matrix_transpose<M, N>(_ a: Matrix<M, N, Float>) -> Matrix<N, M, Float> {
        var entries = Array<Float>(repeating: 0, count: Int(N.value * M.value))
        cblas_sgemm(
            CblasRowMajor,
            CblasTrans,
            CblasNoTrans,
            N.value,
            M.value,
            M.value,
            1.0,
            a.entries,
            N.value,
            Matrix<M, M, Float>.identity().entries,
            M.value,
            0.0,
            &entries,
            M.value
        )
        return Matrix.create(entries)!
    }
}
