# -*- coding: utf-8 -*-
#! /usr/bin/env python
"""
Created on  05 17 19:33:05  2023
@Author: Lulu Shi
@Mails: crazzy_rabbit@163.com
"""
import pandas as pd
import click

def load_data(file):
    data = pd.read_csv(file, delimiter="\t|\s+", 
                       engine='python')
    return data

def results(data, step_size, window_size):
    result = []
    chromosome_length = max(data['pos'])

    for BIN_START in range(1, chromosome_length, step_size):
        BIN_END = BIN_START - 1 + window_size
        if BIN_START + window_size > chromosome_length:
            break

        normxpehh_vals = []
        for _, row in data[(data['pos'] >= BIN_START) & (data['pos'] < BIN_END)].iterrows():
            if not pd.isna(row['pos']):
                normxpehh_vals.append(row['normxpehh'])

        avg_normxpehh = 0
        nvar = 0
        if len(normxpehh_vals) > 0:
            avg_normxpehh = round(sum(normxpehh_vals) / len(normxpehh_vals), 4)
            nvar = len(normxpehh_vals)
        result.append([BIN_START, BIN_END, 
                       avg_normxpehh, nvar])
    return result

@click.command()
@click.option('-f','--file', help='xpehh.out.norm文件，norm后的位点文件，不是区间文件！！', required=True)
@click.option('-c','--chromosome', help='染色体号，因为是分染色体做的', required=True)
@click.option('-w','--window', help='窗口大小', type=int, default=50000)
@click.option('-s','--step', help='步长大小', type=int, default=50000)
def main(file, chromosome, window, step):
    data = load_data(file)
    window_size = window
    step_size = step
    out = results(data, step_size, window_size)

    result_df = pd.DataFrame(out, columns=["BIN_START", "BIN_END", 
                                           "avg_normxpehh", "nvar"])
    result_df.loc[:, 'CHROM'] = chromosome

    if chromosome == 1:
        result_df[["CHROM", "BIN_START", "BIN_END",
                   "nvar", "avg_normxpehh"]].to_csv(f'{chromosome}.XPEHH', sep='\t',
                                                    index=False)
    else:
        result_df[["CHROM", "BIN_START", "BIN_END",
                   "nvar", "avg_normxpehh"]].to_csv(f'{chromosome}.XPEHH', sep='\t',
                                                    index=False, header=False)

if __name__ == '__main__':
    main()
