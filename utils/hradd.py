#!/usr/bin/env python3

def parse_time(timestr):
    timedata = timestr.split(':')
    if len(timedata) != 2:
        raise ValueError(f"error: ill-formatted time value {timestr}")
    try:
        hrs = int(timedata[0])
        mns = int(timedata[1])
    except:
        raise ValueError(f"error: ill-formatted time value {timestr}")
    return (hrs,mns)

def sum_times(times):
    tot_hrs = 0
    tot_mns = 0
    for (hrs,mns) in times:
        tot_hrs += hrs
        tot_mns += mns
    tot_hrs += tot_mns // 60
    tot_mns = tot_mns % 60
    return (tot_hrs,tot_mns)

def main(args):
    times = [parse_time(arg) for arg in args]
    hrs,mns = sum_times(times)
    print(f"{hrs}:{mns}")

if __name__ == "__main__":
    import sys
    try:
        if len(sys.argv) < 2:
            raise ValueError("usage: hradd.py <hr:mn...>")
        main(sys.argv[1:])
    except Exception as e:
        print(e)
