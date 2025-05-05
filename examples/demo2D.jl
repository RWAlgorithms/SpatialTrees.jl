# SPDX-License-Identifier: AGPL-3.0
# Copyright © 2025 Roy Chih Chung Wang <roy.c.c.wang@proton.me>

# run this once: include("a.jl")

import Colors
include("helpers/visualization.jl")

PLT.close("all")
fig_num = 1

const T = Float64
const D = 2

rng = Random.Xoshiro(0)
N = 500
min_t = T(-5.0)
max_t = T(5.0)
max_N_t = 5000

X = collect(randn(rng, T, D) for _ in 1:N)

# # Levels: 2
levels = 2 # 2^(levels-1) leaf nodes. Must be larger than 1.
s_tree = ST.PCTree(X, levels)
X_parts, X_parts_inds = ST.label_leaf_nodes(s_tree, X)


centroid = Statistics.mean(Statistics.mean(x) for x in X_parts)
max_dist = maximum(maximum(norm(xj - centroid) for xj in x) for x in X_parts) * 1.1
y_set = Vector{Vector{T}}(undef, 0)
t_set = Vector{Vector{T}}(undef, 0)
ST.get_partition_lines!(y_set, t_set, s_tree, min_t, max_t, max_N_t, centroid, max_dist)
fig_num, _ = visualize2Dpartition(X_parts, y_set, t_set, fig_num, "levels = $(levels)")
PLT.xlabel("x1")
PLT.ylabel("x2")

# # Levels: 5

levels = 5 # 2^(levels-1) leaf nodes. Must be larger than 1.
s_tree = ST.PCTree(X, levels)
X_parts, X_parts_inds = ST.label_leaf_nodes(s_tree, X)

centroid = Statistics.mean(Statistics.mean(x) for x in X_parts)
max_dist = maximum(maximum(norm(xj - centroid) for xj in x) for x in X_parts) * 1.1
y_set = Vector{Vector{T}}(undef, 0)
t_set = Vector{Vector{T}}(undef, 0)
ST.get_partition_lines!(y_set, t_set, s_tree, min_t, max_t, max_N_t, centroid, max_dist)
fig_num, _ = visualize2Dpartition(X_parts, y_set, t_set, fig_num, "levels = $(levels)")
PLT.xlabel("x1")
PLT.ylabel("x2")

# # query the partition index

x = [0.42; 2.05] # leaf node 14
@show x_region_ind = ST.find_partition(x, s_tree)
@show x
println("Should be node 9.")
println()

x = [3.99; 3.35] # leaf node 15
@show x_region_ind = ST.find_partition(x, s_tree)
@show x
println("Should be node 15.")
println()


nothing
