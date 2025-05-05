# SPDX-License-Identifier: AGPL-3.0
# Copyright © 2025 Roy Chih Chung Wang <roy.c.c.wang@proton.me>

module SpatialTrees

using Statistics, LinearAlgebra
using AbstractTrees

include("utils.jl")
include("partition.jl")
include("visualization/partition_2d.jl")

export PCTree, find_partition, label_leaf_nodes

end # module SpatialTrees
