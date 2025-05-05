# SPDX-License-Identifier: AGPL-3.0
# Copyright © 2025 Roy Chih Chung Wang <roy.c.c.wang@proton.me>

function array2matrix(X::Vector{Vector{T}})::Matrix{T} where {T}

    N = length(X)
    D = length(X[1])

    out = Matrix{T}(undef, D, N)
    for n in 1:N
        out[:, n] = X[n]
    end

    return out
end
