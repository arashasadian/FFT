from math import atan, degrees, radians, sin, cos


scaling_factor = 6072

def cordic_algo(degree):
    x = scaling_factor
    y = 0
    z = radians(degree)
    x_n = 0
    y_n = 0
    s = -1
    if z > 0:
        s = 1
    for i in range(0, 12):
        if z >= 0:
            s = 1
        else:
            s = -1
        t = s * pow(2, -1*i)
        x_n = x - t * y
        y_n = y + t * x
        x = x_n
        y = y_n
        z = z - s * atan(2 ** (-1 * i))
    print("cos {:d} = {:5f}".format(degree, x_n))
    print("sin {:d} = {:5f}".format(degree, y_n))




if __name__ == "__main__":
    degree = 70
    cordic_algo(degree)
    print( "---------")
    print("cos = {:5f}".format(cos(radians(degree))))
    print("sin = {:5f}".format(sin(radians(degree))))
    