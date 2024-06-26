; RUN: opt %loadNPMPolly '-passes=print<polly-detect>' -disable-output < %s 2>&1 | FileCheck %s -match-full-lines
;
; The LoadInst %.b761 is defined outside the SCoP, hence is always constant
; within it. It is no "required invariant load".
; This test is designed to ensure that %.b761 is not added to the list of
; "required invariant loads" which causes an assertion fail in ScopInfo.
; ScopInfo rejects the SCoP, so we cannot check the list if invariant loads.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

%"struct.pov::Frame_Struct.37.89.245.349.401.505.557.713.817.869.1129.1493.1649.2013.2065.2117.2325.3312.36.110.184.258.332.1072" = type { ptr, i32, i32, i32, ptr, ptr, double, double, double, [5 x float], [5 x float], [5 x float], ptr, ptr, ptr, ptr, ptr }
%"struct.pov::Camera_Struct.12.64.220.324.376.480.532.688.792.844.1104.1468.1624.1988.2040.2092.2300.3287.11.85.159.233.307.1047" = type { [3 x double], [3 x double], [3 x double], [3 x double], [3 x double], [3 x double], [3 x double], double, double, i32, double, double, i32, double, double, double, ptr, ptr }
%"struct.pov::Tnormal_Struct.10.62.218.322.374.478.530.686.790.842.1102.1466.1622.1986.2038.2090.2298.3285.9.83.157.231.305.1045" = type { i16, i16, i16, i32, float, float, float, ptr, ptr, ptr, %union.anon.25.9.61.217.321.373.477.529.685.789.841.1101.1465.1621.1985.2037.2089.2297.3284.8.82.156.230.304.1044, float, float }
%"struct.pov::Warps_Struct.1.53.209.313.365.469.521.677.781.833.1093.1457.1613.1977.2029.2081.2289.3276.0.74.148.222.296.1036" = type { i16, ptr, ptr }
%"struct.pov::Pattern_Struct.7.59.215.319.371.475.527.683.787.839.1099.1463.1619.1983.2035.2087.2295.3282.6.80.154.228.302.1042" = type { i16, i16, i16, i32, float, float, float, ptr, ptr, ptr, %union.anon.17.6.58.214.318.370.474.526.682.786.838.1098.1462.1618.1982.2034.2086.2294.3281.5.79.153.227.301.1041 }
%union.anon.17.6.58.214.318.370.474.526.682.786.838.1098.1462.1618.1982.2034.2086.2294.3281.5.79.153.227.301.1041 = type { %struct.anon.21.5.57.213.317.369.473.525.681.785.837.1097.1461.1617.1981.2033.2085.2293.3280.4.78.152.226.300.1040 }
%struct.anon.21.5.57.213.317.369.473.525.681.785.837.1097.1461.1617.1981.2033.2085.2293.3280.4.78.152.226.300.1040 = type { [3 x double], [3 x double], double, double, i16, ptr, i32, [3 x double] }
%"struct.pov::Blend_Map_Struct.4.56.212.316.368.472.524.680.784.836.1096.1460.1616.1980.2032.2084.2292.3279.3.77.151.225.299.1039" = type { i32, i16, i8, i8, ptr }
%"struct.pov::Blend_Map_Entry.3.55.211.315.367.471.523.679.783.835.1095.1459.1615.1979.2031.2083.2291.3278.2.76.150.224.298.1038" = type { float, i8, %union.anon.2.54.210.314.366.470.522.678.782.834.1094.1458.1614.1978.2030.2082.2290.3277.1.75.149.223.297.1037 }
%union.anon.2.54.210.314.366.470.522.678.782.834.1094.1458.1614.1978.2030.2082.2290.3277.1.75.149.223.297.1037 = type { [2 x double], [8 x i8] }
%union.anon.25.9.61.217.321.373.477.529.685.789.841.1101.1465.1621.1985.2037.2089.2297.3284.8.82.156.230.304.1044 = type { %struct.anon.29.8.60.216.320.372.476.528.684.788.840.1100.1464.1620.1984.2036.2088.2296.3283.7.81.155.229.303.1043 }
%struct.anon.29.8.60.216.320.372.476.528.684.788.840.1100.1464.1620.1984.2036.2088.2296.3283.7.81.155.229.303.1043 = type { [3 x double], [3 x double], double, double, i16, ptr, i32, [3 x double] }
%"struct.pov::Transform_Struct.11.63.219.323.375.479.531.687.791.843.1103.1467.1623.1987.2039.2091.2299.3286.10.84.158.232.306.1046" = type { [4 x [4 x double]], [4 x [4 x double]] }
%"struct.pov::Light_Source_Struct.31.83.239.343.395.499.551.707.811.863.1123.1487.1643.2007.2059.2111.2319.3306.30.104.178.252.326.1066" = type { ptr, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, %"struct.pov::Bounding_Box_Struct.22.74.230.334.386.490.542.698.802.854.1114.1478.1634.1998.2050.2102.2310.3297.21.95.169.243.317.1057", ptr, ptr, float, i32, ptr, [5 x float], [3 x double], [3 x double], [3 x double], [3 x double], [3 x double], double, double, double, double, double, ptr, i8, i8, i8, i8, i8, i8, i8, i8, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, [6 x ptr] }
%"struct.pov::Method_Struct.27.79.235.339.391.495.547.703.807.859.1119.1483.1639.2003.2055.2107.2315.3302.26.100.174.248.322.1062" = type { ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr }
%"struct.pov::Ray_Struct.24.76.232.336.388.492.544.700.804.856.1116.1480.1636.2000.2052.2104.2312.3299.23.97.171.245.319.1059" = type { [3 x double], [3 x double], i32, i32, [100 x ptr] }
%"struct.pov::istack_struct.26.78.234.338.390.494.546.702.806.858.1118.1482.1638.2002.2054.2106.2314.3301.25.99.173.247.321.1061" = type { ptr, ptr, i32, i32 }
%"struct.pov::istk_entry.25.77.233.337.389.493.545.701.805.857.1117.1481.1637.2001.2053.2105.2313.3300.24.98.172.246.320.1060" = type { double, [3 x double], [3 x double], [3 x double], [2 x double], ptr, i32, i32, double, double, double, double, double, double, double, double, double, ptr, ptr }
%"struct.pov::Texture_Struct.19.71.227.331.383.487.539.695.799.851.1111.1475.1631.1995.2047.2099.2307.3294.18.92.166.240.314.1054" = type { i16, i16, i16, i32, float, float, float, ptr, ptr, ptr, %union.anon.9.14.66.222.326.378.482.534.690.794.846.1106.1470.1626.1990.2042.2094.2302.3289.13.87.161.235.309.1049, ptr, ptr, ptr, ptr, ptr, i32 }
%union.anon.9.14.66.222.326.378.482.534.690.794.846.1106.1470.1626.1990.2042.2094.2302.3289.13.87.161.235.309.1049 = type { %struct.anon.13.13.65.221.325.377.481.533.689.793.845.1105.1469.1625.1989.2041.2093.2301.3288.12.86.160.234.308.1048 }
%struct.anon.13.13.65.221.325.377.481.533.689.793.845.1105.1469.1625.1989.2041.2093.2301.3288.12.86.160.234.308.1048 = type { [3 x double], [3 x double], double, double, i16, ptr, i32, [3 x double] }
%"struct.pov::Pigment_Struct.17.69.225.329.381.485.537.693.797.849.1109.1473.1629.1993.2045.2097.2305.3292.16.90.164.238.312.1052" = type { i16, i16, i16, i32, float, float, float, ptr, ptr, ptr, %union.anon.0.16.68.224.328.380.484.536.692.796.848.1108.1472.1628.1992.2044.2096.2304.3291.15.89.163.237.311.1051, [5 x float] }
%union.anon.0.16.68.224.328.380.484.536.692.796.848.1108.1472.1628.1992.2044.2096.2304.3291.15.89.163.237.311.1051 = type { %struct.anon.5.15.67.223.327.379.483.535.691.795.847.1107.1471.1627.1991.2043.2095.2303.3290.14.88.162.236.310.1050 }
%struct.anon.5.15.67.223.327.379.483.535.691.795.847.1107.1471.1627.1991.2043.2095.2303.3290.14.88.162.236.310.1050 = type { [3 x double], [3 x double], double, double, i16, ptr, i32, [3 x double] }
%"struct.pov::Finish_Struct.18.70.226.330.382.486.538.694.798.850.1110.1474.1630.1994.2046.2098.2306.3293.17.91.165.239.313.1053" = type { float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, float, [3 x float], [3 x float], [3 x float], float, i32, float, i32 }
%"struct.pov::Interior_Struct.21.73.229.333.385.489.541.697.801.853.1113.1477.1633.1997.2049.2101.2309.3296.20.94.168.242.316.1056" = type { i32, i32, i32, float, float, float, float, float, float, [5 x float], ptr }
%"struct.pov::Bounding_Box_Struct.22.74.230.334.386.490.542.698.802.854.1114.1478.1634.1998.2050.2102.2310.3297.21.95.169.243.317.1057" = type { [3 x float], [3 x float] }
%"struct.pov::Project_Tree_Node_Struct.30.82.238.342.394.498.550.706.810.862.1122.1486.1642.2006.2058.2110.2318.3305.29.103.177.251.325.1065" = type { i16, ptr, %"struct.pov::Project_Struct.29.81.237.341.393.497.549.705.809.861.1121.1485.1641.2005.2057.2109.2317.3304.28.102.176.250.324.1064", i16, ptr }
%"struct.pov::BBox_Tree_Struct.28.80.236.340.392.496.548.704.808.860.1120.1484.1640.2004.2056.2108.2316.3303.27.101.175.249.323.1063" = type { i16, i16, %"struct.pov::Bounding_Box_Struct.22.74.230.334.386.490.542.698.802.854.1114.1478.1634.1998.2050.2102.2310.3297.21.95.169.243.317.1057", ptr }
%"struct.pov::Project_Struct.29.81.237.341.393.497.549.705.809.861.1121.1485.1641.2005.2057.2109.2317.3304.28.102.176.250.324.1064" = type { i32, i32, i32, i32 }
%"struct.pov::Object_Struct.23.75.231.335.387.491.543.699.803.855.1115.1479.1635.1999.2051.2103.2311.3298.22.96.170.244.318.1058" = type { ptr, i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, %"struct.pov::Bounding_Box_Struct.22.74.230.334.386.490.542.698.802.854.1114.1478.1634.1998.2050.2102.2310.3297.21.95.169.243.317.1057", ptr, ptr, float, i32 }
%"struct.pov::Media_Struct.20.72.228.332.384.488.540.696.800.852.1112.1476.1632.1996.2048.2100.2308.3295.19.93.167.241.315.1055" = type { i32, i32, i32, i32, i32, double, i32, double, double, i32, i32, i32, i32, [5 x float], [5 x float], [5 x float], [5 x float], double, double, double, ptr, double, i32, i32, ptr, ptr }
%"struct.pov::Fog_Struct.33.85.241.345.397.501.553.709.813.865.1125.1489.1645.2009.2061.2113.2321.3308.32.106.180.254.328.1068" = type { i32, double, double, double, [5 x float], [3 x double], ptr, float, ptr }
%"struct.pov::Turb_Struct.32.84.240.344.396.500.552.708.812.864.1124.1488.1644.2008.2060.2112.2320.3307.31.105.179.253.327.1067" = type { i16, ptr, ptr, [3 x double], i32, float, float }
%"struct.pov::Rainbow_Struct.34.86.242.346.398.502.554.710.814.866.1126.1490.1646.2010.2062.2114.2322.3309.33.107.181.255.329.1069" = type { double, double, double, double, double, double, double, [3 x double], [3 x double], [3 x double], ptr, ptr }
%"struct.pov::Skysphere_Struct.35.87.243.347.399.503.555.711.815.867.1127.1491.1647.2011.2063.2115.2323.3310.34.108.182.256.330.1070" = type { i32, ptr, ptr }
%"struct.pov::light_group_light_struct.36.88.244.348.400.504.556.712.816.868.1128.1492.1648.2012.2064.2116.2324.3311.35.109.183.257.331.1071" = type { ptr, ptr }

@_ZN3pov5FrameE = external global %"struct.pov::Frame_Struct.37.89.245.349.401.505.557.713.817.869.1129.1493.1649.2013.2065.2117.2325.3312.36.110.184.258.332.1072", align 8
@_ZN3povL27Precompute_Camera_ConstantsE = external unnamed_addr global i1, align 4

; Function Attrs: uwtable
define fastcc void @_ZN3povL10create_rayEPNS_10Ray_StructEddi() unnamed_addr {
entry:
  %0 = load ptr, ptr @_ZN3pov5FrameE, align 8
  %.b761 = load i1, ptr @_ZN3povL27Precompute_Camera_ConstantsE, align 4
  br label %if.end79

if.end79:                                         ; preds = %entry
  %arraydecay89 = getelementptr inbounds %"struct.pov::Camera_Struct.12.64.220.324.376.480.532.688.792.844.1104.1468.1624.1988.2040.2092.2300.3287.11.85.159.233.307.1047", ptr %0, i64 0, i32 3, i64 0
  %1 = load double, ptr %arraydecay89, align 8
  br i1 %.b761, label %if.then87, label %if.end79.if.end100_crit_edge

if.end79.if.end100_crit_edge:                     ; preds = %if.end79
  br label %if.end100

if.then87:                                        ; preds = %if.end79
  br label %if.end100

if.end100:                                        ; preds = %if.then87, %if.end79.if.end100_crit_edge
  tail call void @_ZN3pov30initialize_ray_container_stateEPNS_10Ray_StructEi()
  br label %sw.epilog

sw.epilog:                                        ; preds = %if.end100
  unreachable
}

; Function Attrs: uwtable
declare void @_ZN3pov30initialize_ray_container_stateEPNS_10Ray_StructEi() local_unnamed_addr #0


; CHECK: Valid Region for Scop: if.end79 => if.end100

; CHECK-NOT: Invariant Accesses:
