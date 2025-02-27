module QueueCompatibility_140(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [5:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [5:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ram [0:1]; // @[Decoupled.scala 224:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 224:95]
  wire  ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 224:95]
  wire [5:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 224:95]
  wire [5:0] ram_MPORT_data; // @[Decoupled.scala 224:95]
  wire  ram_MPORT_addr; // @[Decoupled.scala 224:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 224:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 224:95]
  reg  enq_ptr_value; // @[Counter.scala 60:40]
  reg  deq_ptr_value; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 227:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 228:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 229:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 230:24]
  wire  _do_enq_T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _do_deq_T = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _GEN_12 = io_deq_ready ? 1'h0 : _do_enq_T; // @[Decoupled.scala 270:{27,36}]
  wire  do_enq = empty ? _GEN_12 : _do_enq_T; // @[Decoupled.scala 267:18]
  wire  do_deq = empty ? 1'h0 : _do_deq_T; // @[Decoupled.scala 267:18 269:14]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 224:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = empty ? _GEN_12 : _do_enq_T;
  assign io_enq_ready = ~full; // @[Decoupled.scala 254:19]
  assign io_deq_valid = io_enq_valid | ~empty; // @[Decoupled.scala 253:16 266:{25,40}]
  assign io_deq_bits = empty ? io_enq_bits : ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 262:17 267:18 268:19]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 224:95]
    end
    if (reset) begin // @[Counter.scala 60:40]
      enq_ptr_value <= 1'h0; // @[Counter.scala 60:40]
    end else if (do_enq) begin // @[Decoupled.scala 237:17]
      enq_ptr_value <= enq_ptr_value + 1'h1; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Counter.scala 60:40]
      deq_ptr_value <= 1'h0; // @[Counter.scala 60:40]
    end else if (do_deq) begin // @[Decoupled.scala 241:17]
      deq_ptr_value <= deq_ptr_value + 1'h1; // @[Counter.scala 76:15]
    end
    if (reset) begin // @[Decoupled.scala 227:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 227:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 244:28]
      if (empty) begin // @[Decoupled.scala 267:18]
        if (io_deq_ready) begin // @[Decoupled.scala 270:27]
          maybe_full <= 1'h0; // @[Decoupled.scala 270:36]
        end else begin
          maybe_full <= _do_enq_T;
        end
      end else begin
        maybe_full <= _do_enq_T;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram[initvar] = _RAND_0[5:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

