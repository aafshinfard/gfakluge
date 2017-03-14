/**
 * Merges a set of GFA files by:
 * 1. Coordinate their ID spaces (assume each one is an independent subgraph)
 * 2. Add both to a single GFAKluge instance. This will provide a sort.
 * 3. Push out the new GFA files to stdout.
 */
#include "gfakluge.hpp"
#include <getopt.h>
#include <string>
#include <iostream>


int main(int argc, char** argv){
    vector<string> g_files;
    bool block_order = false;

    if (argc == 1){
        cerr << "gfa_sort [-b ] -i <GFA_File> >> my_sorted_gfa.gfa" << endl;
        exit(0);
    }

    int c;
    while (true){
        static struct option long_options[] =
        {
            {"help", no_argument, 0, 'h'},
            {"block-order", no_argument, 0, 'b'},
            {"gfa-file", required_argument, 0, 'i'},
            {0,0,0,0}
        };
    
        int option_index = 0;
        c = getopt_long(argc, argv, "hbi:", long_options, &option_index);
        if (c == -1){
            break;
        }

        switch (c){
            case 'i':
                g_files.push_back( optarg );
                break;

            case '?':
            case 'h':
                cerr << "gfa_merge [-b --block-order ] -i <GFA_File> -i <OTHER_GFA_FILE> >> my_sorted_gfa.gfa" << endl;
                exit(0);

            case 'b':
                block_order = true;
                break;

            default:
                abort();
        }
    }

    // TODO how to merge the various GFAKLuge objs?
    // Merge their backing containers??
    for (auto gfi : g_files){
        GFAKluge gg;
        gg.parse_gfa_file(gfi);
    }
    // cout << big_gg.to_string;


}
