# Adventures with Intel SSDs

## Notes from Intel

* Unlike NAND, there is no concept of an erase block so there is no difference
  between host bytes written and device bytes written.  There is no write
  amplification.
* Intel expects a warm-up period of two or three __hours__ before the drive will
  perform optimally.  However there is no memory effect; the drive should
  perform as well on its first write as its trillionth.

## Testbed Configuration

Four nodes:

1. dv160 - 2x Intel DC P4800X (750 GB) 8086:7201
2. dv161 - 2x Intel DC P4800X (750 GB) 8086:7201
3. dv162 - 2x Intel DC P4800X (750 GB) 8086:7201
4. dv163

These devices are attached to the second socket of these dev nodes.

## ISDCT

Check out the [Intel SSD Data Center Tool User Guide][].

[Intel SSD Data Center Tool User Guide]: https://www.intel.com/content/dam/support/us/en/documents/memory-and-storage/Intel_SSD_DCT_3_0_x_User_Guide.pdf

### List drives and indices

    $ isdct show -intelssd

    - Intel Optane(TM) SSD DC P4800X Series PHKE745000SY750BGN -
    
    Bootloader : EB3B0416
    DevicePath : /dev/nvme0n1
    DeviceStatus : Healthy
    Firmware : E2010435
    FirmwareUpdateAvailable : The selected Intel SSD contains current firmware as of this tool release.
    Index : 0
    ModelNumber : INTEL SSDPE21K750GA
    ProductFamily : Intel Optane(TM) SSD DC P4800X Series
    SerialNumber : PHKE745000SY750BGN


### Low-level format

    $ isdct start -intelssd 0 -nvmeformat

where `-intelssd 0` refers to `Index : 0` from `isdct show -intelssd` output.
