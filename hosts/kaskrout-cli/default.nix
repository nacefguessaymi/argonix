# hosts/matebook/default.nix
# Huawei MateBook X Pro (2018), MACH-W29
# DMI: HUAWEI MACH-WX9 / board MACH-WX9-PCB
# i7-8550U, UHD 620 + MX150 (Optimus), 16GB
#
# Fingerprint: Goodix GXFP5187 (SPI), firmware GF3288_ST411SEC_APP_11033
#   goodixtls driver (out-of-tree; upstream MR libfprint!680)
#   needs: spidev bound to spi-GXFP5187:00, spidev bufsiz=65536,
#          fprintd DeviceAllow=/dev/gpiochip0 rw, fprintd --no-timeout
#   reset GPIO: gpiochip0 line 58 (from ACPI _CRS)
#   wedged sensor: power off on battery, wait ~2 min (reboot won't clear)
#   PAM: pam_fprintd sufficient before system-auth (sudo, polkit-1)
#
# TPM: Intel PTT 2.0, fw 302.12 (lockout auth set, likely by Windows)
#   passkeys: passkey-tpm (virtual FIDO2 key via uhid, fprintd UV)
#   keys are TPM-bound: TPM clear / BIOS update can wipe them
