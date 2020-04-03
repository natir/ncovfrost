#!/usr/bin/env python

import sys
import pysam

from collections import defaultdict as ddict

def main(args=None):
    
    if args is None:
        args = sys.argv[1:]

    map2human = pysam.AlignmentFile(args[0], "rb")
    map2sras = pysam.AlignmentFile(args[1], "rb")

    id2mapping = ddict(lambda: {"human": 0, "sras": 0})
    
    for mapping in map2human:
        if mapping.is_unmapped:
            id2mapping[mapping.query_name]["human"] = -1
            continue

        length = mapping.infer_query_length()

        if id2mapping[mapping.query_name]["human"] < length:
            id2mapping[mapping.query_name]["human"] = length

    for mapping in map2sras:
        if mapping.is_unmapped:
            id2mapping[mapping.query_name]["sras"] = -1
            continue

        length = mapping.infer_query_length()

        if id2mapping[mapping.query_name]["sras"] < length:
            id2mapping[mapping.query_name]["sras"] = length


    print("query_name\thuman\tsras")
    for (read_id, value) in id2mapping.items():
        print(f"{read_id}\t{value['human']}\t{value['sras']}")
            
if __name__ == "__main__":
    main(sys.argv[1:])
