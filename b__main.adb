pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E124 : Short_Integer; pragma Import (Ada, E124, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "ada__containers_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "ada__io_exceptions_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__strings_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__strings__maps_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "ada__strings__maps__constants_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__tags_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "ada__streams_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "interfaces__c_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "interfaces__c__strings_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exceptions_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "system__file_control_block_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "ada__streams__stream_io_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "system__file_io_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__finalization_root_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "ada__finalization_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__storage_pools_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__finalization_masters_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__storage_pools__subpools_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "system__task_info_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "gnat__secure_hashes_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "gnat__secure_hashes__sha2_common_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "gnat__secure_hashes__sha2_64_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__assertions_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__pool_global_E");
   E154 : Short_Integer; pragma Import (Ada, E154, "gnat__sockets_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "system__pool_size_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "ada__strings__unbounded_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "gnat__sha512_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "gnat__sockets__thin_common_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "gnat__sockets__thin_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "gnat__string_split_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "system__strings__stream_ops_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "system__tasking__initialization_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "ada__real_time_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "ada__text_io_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "system__tasking__protected_objects_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "system__tasking__protected_objects__entries_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "system__tasking__queuing_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "system__tasking__stages_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "datatypes_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "gui_to_server_communication_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "protocol_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "gui2client_communication_E");
   E097 : Short_Integer; pragma Import (Ada, E097, "concrete_client_logic_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "user_databases_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "concrete_server_logic_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "concrete_server_logic__finalize_body");
      begin
         E191 := E191 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "concrete_server_logic__finalize_spec");
      begin
         F2;
      end;
      E254 := E254 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "user_databases__finalize_spec");
      begin
         F3;
      end;
      E097 := E097 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "concrete_client_logic__finalize_spec");
      begin
         F4;
      end;
      E129 := E129 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "datatypes__finalize_spec");
      begin
         F5;
      end;
      E233 := E233 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F6;
      end;
      E115 := E115 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "ada__text_io__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gnat__sockets__finalize_body");
      begin
         E154 := E154 - 1;
         F8;
      end;
      E044 := E044 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__strings__unbounded__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__file_io__finalize_body");
      begin
         E120 := E120 - 1;
         F10;
      end;
      E075 := E075 - 1;
      E071 := E071 - 1;
      E163 := E163 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__pool_size__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "gnat__sockets__finalize_spec");
      begin
         F12;
      end;
      E144 := E144 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__pool_global__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "system__storage_pools__subpools__finalize_spec");
      begin
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__finalization_masters__finalize_spec");
      begin
         F15;
      end;
      E150 := E150 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "ada__streams__stream_io__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, True, True, False, False, False, 
           False, False, False, True, True, True, False, False, 
           True, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, False, True, 
           False, True, False, False, True, False, True, False, 
           False, True, False, False, False, True, False, False, 
           True, True, False, True, True, False, False, False, 
           True, False, True, True, True, False, False, True, 
           False, False, True, False, True, True, False, True, 
           True, True, False, True, False, False, False, False, 
           False, True, True, False, False, False),
         Count => (0, 0, 0, 0, 0, 1, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E021 := E021 + 1;
      Ada.Containers'Elab_Spec;
      E101 := E101 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E084 := E084 + 1;
      Ada.Strings'Elab_Spec;
      E042 := E042 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E111 := E111 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E083 := E083 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E023 := E023 + 1;
      System.File_Control_Block'Elab_Spec;
      E127 := E127 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E150 := E150 + 1;
      System.Finalization_Root'Elab_Spec;
      E086 := E086 + 1;
      Ada.Finalization'Elab_Spec;
      E081 := E081 + 1;
      System.Storage_Pools'Elab_Spec;
      E088 := E088 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E209 := E209 + 1;
      E133 := E133 + 1;
      E140 := E140 + 1;
      Gnat.Secure_Hashes.Sha2_64'Elab_Spec;
      E135 := E135 + 1;
      System.Assertions'Elab_Spec;
      E142 := E142 + 1;
      System.Pool_Global'Elab_Spec;
      E144 := E144 + 1;
      Gnat.Sockets'Elab_Spec;
      System.Pool_Size'Elab_Spec;
      E163 := E163 + 1;
      E071 := E071 + 1;
      System.Finalization_Masters'Elab_Body;
      E075 := E075 + 1;
      System.File_Io'Elab_Body;
      E120 := E120 + 1;
      E159 := E159 + 1;
      E122 := E122 + 1;
      Ada.Tags'Elab_Body;
      E055 := E055 + 1;
      E048 := E048 + 1;
      System.Soft_Links'Elab_Body;
      E011 := E011 + 1;
      System.Os_Lib'Elab_Body;
      E124 := E124 + 1;
      System.Secondary_Stack'Elab_Body;
      E015 := E015 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E044 := E044 + 1;
      Gnat.Sha512'Elab_Spec;
      E131 := E131 + 1;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E161 := E161 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E157 := E157 + 1;
      Gnat.Sockets'Elab_Body;
      E154 := E154 + 1;
      Gnat.String_Split'Elab_Spec;
      E100 := E100 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E148 := E148 + 1;
      System.Tasking.Initialization'Elab_Body;
      E221 := E221 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E245 := E245 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E115 := E115 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E229 := E229 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E233 := E233 + 1;
      System.Tasking.Queuing'Elab_Body;
      E237 := E237 + 1;
      System.Tasking.Stages'Elab_Body;
      E243 := E243 + 1;
      Datatypes'Elab_Spec;
      E129 := E129 + 1;
      Gui_To_Server_Communication'Elab_Spec;
      E252 := E252 + 1;
      E171 := E171 + 1;
      Gui2client_Communication'Elab_Spec;
      E169 := E169 + 1;
      Concrete_Client_Logic'Elab_Spec;
      Concrete_Client_Logic'Elab_Body;
      E097 := E097 + 1;
      User_Databases'Elab_Spec;
      E254 := E254 + 1;
      Concrete_Server_Logic'Elab_Spec;
      Concrete_Server_Logic'Elab_Body;
      E191 := E191 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   E:\Development\Ada\Block_Projekt\ada_chat\datatypes.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\gui_to_server_communication.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\protocol.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\gui2client_communication.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\concrete_client_logic.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\user_databases.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\concrete_server_logic.o
   --   E:\Development\Ada\Block_Projekt\ada_chat\main.o
   --   -LE:\Development\Ada\Block_Projekt\ada_chat\
   --   -LE:\Development\Ada\Block_Projekt\ada_chat\
   --   -LE:/programme/gnat/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lws2_32
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
