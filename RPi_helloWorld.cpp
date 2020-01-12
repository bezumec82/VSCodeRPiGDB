#include <iostream>

#include <arm_acle.h>
#include <arm_neon.h>

#define MAX_COUNT 10
#define HASH_SIZE 101

int main (void)
{
    float32x4_t HASH_SEED = { 51E-8, 71.1E-8, 41.5E-8, 17.6E-8 };
    float32x4_t f4vec = { 51.2, 23.1, 67.5, 83.6 };
    for (int j; j < 100000; j++ )
    {
		for (int i = 0; i < MAX_COUNT; ++i)
		{
			f4vec = vmlaq_f32(f4vec, f4vec, HASH_SEED);
		}
		float values[4] = { 29.0, 71.1, 41.5, 17.6 };
		f4vec = vld1q_f32(values);

    }
    ::std::cout 	   << vgetq_lane_f32(f4vec, 0)
    			<< ":" << vgetq_lane_f32(f4vec, 1)
				<< ":" << vgetq_lane_f32(f4vec, 2)
				<< ":" << vgetq_lane_f32(f4vec, 3) << '\n';
	::std::cout << "FUCKING Hello World!!!" << ::std::endl;
    return (static_cast<int>(vgetq_lane_f32(f4vec, 0))) % HASH_SIZE;
}
