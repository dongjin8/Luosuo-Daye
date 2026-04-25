#ifndef _BOARD_CONFIG_H_
#define _BOARD_CONFIG_H_

#include <driver/gpio.h>

#define AUDIO_INPUT_SAMPLE_RATE  16000
#define AUDIO_OUTPUT_SAMPLE_RATE 24000

// I2S 全双工模式：INMP441 (录音) + MAX98357A (播放) 共用 BCLK/WS
// C3 I2S0 通过 GPIO Matrix 路由，无固定引脚限制
#define AUDIO_I2S_GPIO_WS   GPIO_NUM_7
#define AUDIO_I2S_GPIO_BCLK GPIO_NUM_4
#define AUDIO_I2S_GPIO_DIN  GPIO_NUM_3   // INMP441 SD (录音)
#define AUDIO_I2S_GPIO_DOUT GPIO_NUM_10  // MAX98357A DIN (播放)

#define BUILTIN_LED_GPIO     GPIO_NUM_8   // 板载 LED
#define BOOT_BUTTON_GPIO     GPIO_NUM_9   // 板载 BOOT 按键 (对话触发)

// 板载 SSD1306 OLED 0.42寸 72x40, I2C 地址 0x3C
#define DISPLAY_SDA_PIN GPIO_NUM_5
#define DISPLAY_SCL_PIN GPIO_NUM_6
#define DISPLAY_WIDTH   128
#define DISPLAY_HEIGHT  64  // SSD1306 驱动按 128x64 初始化，OledDisplay 会自动处理偏移

#define DISPLAY_MIRROR_X false
#define DISPLAY_MIRROR_Y false

#endif // _BOARD_CONFIG_H_
