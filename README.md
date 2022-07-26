# Assembly Shenanigans

My attempt to teach others about microprocessors and programming in IA-32 and IA-64 assembly, and to spread the word of how awesome it is.

# Table of contents

- [Pre-requisites](#pre-requisites)
	- [Architecture Model](#architecture-model)
	- [ CPU ](#cpu)
	- [Registers](#registers)
	- [Bus](#bus)
	- [Clock Speed](#clock-speed)
	- [Fetch-decode-execute cycle](#fetch-decode-execute-cycle)
	- [Memory addressing ](#memory-addressing)
	- [Instructions](#instructions)
	- [Instruction Set Architecture](#instruction-set-architecture)
		- [Basics](#basics)
		- [Approaches to ISA on the basis of architectural complexity](#approaches-to-isa-on-the-basis-of-architectural-complexity)
		- [Microarchitecture](#microarchitecture)
		- [What does 32 and 64 bit actually mean?](#what-does-32-bit%2C-64-bit-etc-actually-mean)
	- [Micro-processor, micro-controller, and micro-computer](#micro-processor%2C-micro-controller%2C-and-micro-computer)
	- [Difference b/w CPU, Processor and Core](#difference-b%2Fw-cpu%2C-processor-and-core)

# Pre-requisites

## Architecture model

The core elements of today's modern computing devices are consistent with those designed in the dawning phase of technology. So it's always good to study them beforehand, before moving onto its complex counterparts.

Architecture model | Description
-|-
Von Neumann | According to this architecture model, data and memory addresses in the same memory (you'll come to understand more about this later, the distinction is important in the case of [shellcoding](https://en.wikipedia.org/wiki/Shellcode)).
Harvard Architecture | According to this model, the data and the address are stored in different places


## CPU

A CPU has many internal components which we will discuss about, one by one; namely: Control Unit, Arithmetic Logic Unit (ALU), Registers, Cache, and Buses.


Name | Description
-|-
Control Unit | <li>It acts as a supervisor for different components of the CPU.</li><li>Controls the fetch-decode-execute cycle</li>
Arithmetic Logic Unit (ALU) | <li>Consists of **Arithmetic Unit** and **Logic Unit**</li><li>The arithmetic unit is responsible for performing mathematical operations (addition, subtraction and the likes)</li><li>The Logic Unit is responsible for the logical operations (XOR, AND, OR etc)</li>
Registers | <li>The smallest data holding elements that are build into the CPU and are directly accessible without any performance penalty</li><li>They're used to store instructions and values in the CPU that help execute the instructions without having to refer back to the main memory which is an expensive operation</li><li>Their storage capacity is limited in nature, which depends on the architecture, for example, registers are 64-bit in size in the case of `amd64`, and they're also limited in number</li>
CPU Clock | Speaking from the low level perspective, the CPU is just another creation of sequential and combinational logic. We need a clock to synchronize the internal circuitry. The clock does the job, by sending electric pulses at regular intervals, which is able to dictate how fast the CPU is able to execute its internal logic.
Cache | <li>They were designed, because without them, a microprocessor would have to sit idle for many cycles until the required data could come into the registers from the main memory.</li><li>They're built into the processor, and used to proactively store data pulled from the memory to enable fast access</li><li>**Cache Coherency**: A concept related to multi-threading/ multi-processing environments, where more than one entity might be looking at certain information. When that information is updated, it must be updated across all the places it’s stored at, be it the cache, the registers, RAM etc, otherwise problems will occur if obsolete data is in place.</li>


## Registers

The number of possible registers depends from architecture to architecture, but they can be categorized into:

Name | Description
-|-
Accumulator | The most frequently used register, sometimes built into the ALU, used to store intermediary data when logical/ arithmetic calculations are being done
Instruction register | Holds the instruction which is just about to be executed by the processor.
Program Counter (Instruction Pointer) | Used to keep track of the execution, and points to the next instruction which needs to be executed after the current one
Counters | Used in loops
Stack/ Base Pointer | Used to point to the top and base of the stack respectively, extremely important to understand the concept of _Stack Frames_.
FLAGS | A register in which each bit is independent of one another, and stores information about the current status at any given stage of program execution.
Additional registers | Depends on the architecture, and they're extensions to the basic set of registers, such as x87, MMX, SSE etc.

In the case of x86_64, general purpose registers are 64-bits in size.
- The lower 32-bits of `RAX`, `RBX`, `RCX`, `RDX` can be accessed via `EAX`, `EBX`, `ECX`, and `EDX`, their lower 16-bits by `AX`, `BX`, `CX` and `DX`. The lower half of the said 16-bits by `AL`, `BL`, `CL`, `DL` and the upper half by `AH`, `BH`, `CH` and `DH`.
- GPR `RSI`, `RDI`, `RBP` and `RSP` are 64-bits in size, and their lower 32-bits can be accessed by `ESI`, `EDI`, `EBP`, `ESP`, and their lower 16-bits can be accessed by `SI`, `DI`, `BP`, `SP` and their lower 8- bits can be accessed by `SIL`, `DIL`,  `BPL` and `SPL`.
- There are other 8 GPR, named from `R8` - `R15`. The whole 64-bits can be accessed via `R8`, the lower 32-bits via `R8D` (double word), the lower 16-bits via `R8W` (R8-word), and further lower 8-bits via `R8B` (R8-byte)
- Due to various design decisions made during the design of x86_64, accessing EAX would wipe out the upper 32-bits of the RAX register (and all other GPRs)

```
 General purpose registers: 64 bit                        RSI, RDI, RSP, RBP
 RAX, RBX, RCX, RDX                              R8, R9, R10, R11, R12, R13, R14, R15



┌──────────────────RAX──────────────────┐      ┌─────────────RSI/R8────────────────────┐
┌───────────────────┬─────────┬────┬────┐      ┌───────────────────┬─────────┬────┬────┐
│                   │         │    │    │      │                   │         │    │SIL │
│                   │         │AH  │AL  │      │                   │         │    │R8B │
└───────────────────┴─────────┴────┴────┘      └───────────────────┴─────────┴────┴────┘
                              └───AX────┘                                    └─SI/R8W──┘
                    └───────EAX─────────┘                          └────ESI/R8D────────┘
```

## Bus

- A bus is a group of wires having common functionality, and they're used to interconnect stuff internally within the CPU.
- Some higher end systems use switch instead of the bus-based architecture but that's outside the scope of this post.

Name | Description
-|-
Control Bus | Bi-directional in nature (CPU <---> other parts), and are used to control the data flow. Control signals are transferred through this bus, and they synchronize everything connected to the data bus.
Address Bus | <li>Unidirectional in nature (CPU ---> other parts), and are used to transfer addresses from the microprocessor to the other components. Memory addresses are transferred through this lines.</li><li>Used to define the amount of addressable memory by the microprocessor, say if there are 16-address lines (like that in Intel 8085), $$2^{16}$$ memory addresses can be addressed by the microprocessor, and $$2^{16}$$ bytes of memory if we consider it to be byte-addressable.</li>
Data Bus    | <li>They are used for data transmission b/w the micro-processor and other peripherals, and within the microprocessor as well</li><li>They're bidirectional in nature and are used to define the native word size</li>

## Clock Speed

The CPU works on the basis Fetch-Decode-Execute cycle, the clock rate of a CPU, is the number of times this cycle occurs per second. It’s often used as an indication of processor's speed.


## Fetch Decode Execute Cycle

- Most of the modern day CPUs support _stored program execution_, which means the instructions to be executed will firstly exist in the memory, which will later be fetched into the registers, decoded and executed. This process is known as **Fetch Decode Execute**.
- The Control Unit drives the fetch, decode, execute and store functions of the processor

```
initialise the program counter
repeat forever
	fetch instruction
	increment the program counter
	decode the instruction
	execute the instruction
end repeat

              ┌────────────┐
       ┌──────►Control Unit├────┐
       │      └────────────┘    │Execute
Decode │                        │
    ┌──┴──────┐               ┌─▼─┐
    │Registers◄───────────────┤ALU│
    └─────────┘   Fetch       └───┘
```

Step | Description
-|-
Fetch | <li>The CPU fetches instructions from the physical memory using their memory addresses (mentioned in Program Counter/ Instruction Pointer), which is then stored in the Instruction Register.</li><li>Before the instruction is fetched, the Control Unit generates and sends out a control signal (Memory Read) to the primary memory to let it know it’s about to get accessed, then the the instruction is fetched through the  data lines.</li>
Decode | <li>The CPU interprets the binary instruction to determine what task it’s supposed to perform and transfers the data needed to the registers to prepare to execute the specific instruction</li><li>Instructions are formatted in a particular way to enable efficient decoding, and it specifies opcode (operations to be performed) and operands (what to perform the operations on), and also the addressing mode.</li><li>Decoder circuity is used here (such as 8 to 256 line decoder and all)</li>
Execute | <li>At this stage, binary instruction is decoded and one of the output lines is applied, to perform the task in hand, whatever it may be.</li><li>After execution of an instruction is done, the instruction pointer (Program Counter) now points to a new location where the next instruction will be stored and this cycle repeats again.</li>


## Memory Addressing

```
The number and order of operands depends on the instruction addressing mode as follows:
Addressing Modes

Register Direct: Both the operands are registers
ADD EAX, EAX

Register Indirect:Both the operands are registers, but contains the address where the operands are stored in memory
MOV ECX, [EBX]

Immediate: The operand is included immediately after the instruction in memory
ADD EAX, 10

Indexed: The address is calculated using a base address plus an index, which can be another register
MOV A, [ESI+0x4010000]
MOV EAX, [EBX+EDI]
```

## Instructions 

Name | Description
-|-
Mnemonics | <li>These are the mappings for the binary machines codes so as to enable faster writing, and debugging of code. </li><li>We need an assembler to convert assembly (mnemonics) code to native format</li><li>The mappings are defined by the ISA, such as in the 8085 architecture, A register is the mapping for 111, and ADD is the mapping for 10000, when we assemble our code for say ADD A it would get translated to (10000)(111)</li>
Machine code | They can be understood by the micro-processor directly w/o any need of middle man.


## Instruction Set Architecture

### Basics

- Instructions are defined as per a specification, which is known as the Instruction Set Architecture (ISA). It's specifies things such as type and size of operands, register states, memory model, how interrupts and exceptions are handled etc viz. it's the syntax and semantics.
- Some examples are: x86, x86_64, ARM, MIPS, Power PC, RISC-V etc

### Approaches to ISA on the basis of architectural complexity

Name | Description
-|-
Complex Instruction Sets | <li>More work is done in a single instruction (capable of multi-step operations), and takes as much time as it needs for execution.</li><li>Many instructions are supported</li><li>A computer built with this set is known as Complex Instruction Set Computer (CISC)</li><li>Example: Motorola 6800, Intel 8051 family.</li>
Reduced Instruction Sets | <li>An optimised set of instructions that the CPU can execute quickly</li><li>Supports less number of instructions</li><li>A computer built with this instruction set is known as Reduced Instruction Set Computer (RISC)</li><li>Example: RISC-V, PowerPC</li>

Some other approaches are: Minimal Instruction Set Computer (MISC), One Instruction Set Computer (OISC) and Very Long Instruction Word (VLIW), LIW (Long Instruction Word) but these are not so common these days.

### Microarchitecture

Micro-architecture is how the instruction set is implemented. There are multiple micro-architecture that support the same ISA, such as such as both Intel and AMD support the x86 ISA, but they have different implementation (micro-architecture)

### What does 32-bit, 64-bit etc actually mean

- Used to define the native word-size of the ISA, and that is what the CPU processes at once viz. if the word size is 1 byte, 1 byte of data can be processed in a single fetch-decode-execute cycle
- If there are 8-data lines as per the ISA, it means 8-bits can be transferred simultaneously at once, viz. the each distinct register can store 8 bits each, thus the CPU is 8-bit in nature. The address bus is irrelevant with classification of CPUs.
- The native word size also defines the addressable memory, because special purpose registers (program counter, instruction register) are used as pointers to memory location, and the native word size defines the sizes of these registers.
- A 32/64 bit program has different meaning from a 32/64 bit CPU. A 32-bit program means the CPU will operate in 32-bit mode, and only $2^{32}$ addresses will be accessible.

## Micro-processor, micro-controller, and micro-computer

Name | Description
-|-
Micro-processor  | An electronic chip functioning as the CPU of computer
Micro-controller | It’s the combination of micro-processor, I/O ports, and memory altogether.
Micro-computer   | A computer having a microprocessor and limited resources is known as a micro-computer, and is the combination of a micro-controller, I/O devices and memory.

## Difference b/w CPU, Processor and Core

```
CPU = the hardware that executes instructions, can have multiple cores in it
Processor = A physical chip containing one or more CPUs
Core = The basic computational unit of CPU
Multicore = Having multiple cores on the same CPU
Multiprocessor = Having multiple processors
```
