# SPDX-License-Identifier: AGPL-3.0
# Copyright © 2025 Roy Chih Chung Wang <roy.c.c.wang@proton.me>

using Test, Random
import SpatialTrees as ST

@testset "2D query" begin


    T = Float64
    D = 2

    rng = Random.Xoshiro(0)
    N = 500
    min_t = T(-5.0)
    max_t = T(5.0)
    max_N_t = 5000

    X = collect(randn(rng, T, D) for _ in 1:N)

    # # Levels: 5

    levels = 5 # 2^(levels-1) leaf nodes. Must be larger than 1.
    s_tree = ST.PCTree(X, levels)
    X_parts, X_parts_inds = ST.label_leaf_nodes(s_tree, X)

    # # query the partition index

    x = [0.42; 2.05] # leaf node 9
    x_region_ind = ST.find_partition(x, s_tree)
    @test x_region_ind == 9

    x = [3.99; 3.35] # leaf node 15
    x_region_ind = ST.find_partition(x, s_tree)
    @test x_region_ind == 15
end
