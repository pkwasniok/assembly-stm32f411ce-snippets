DIR = build
TOOLCHAIN = arm-none-eabi

flash: build
	openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program ./build/pwm verify reset exit"

build: clean link

link: main.o
	$(TOOLCHAIN)-gcc -T link.ld -nostdlib -o build/pwm build/main.o

main.o:
	$(TOOLCHAIN)-as -c -g -o $(DIR)/main.o main.s

clean:
	del build\pwm
	del build\main.o