pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E185 : Short_Integer; pragma Import (Ada, E185, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "ada__containers_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "ada__io_exceptions_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__strings_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__strings__maps_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "ada__strings__maps__constants_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__tags_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "ada__streams_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "interfaces__c_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "interfaces__c__strings_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exceptions_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "system__file_control_block_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "ada__streams__stream_io_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "system__file_io_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__finalization_root_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "ada__finalization_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__storage_pools_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__finalization_masters_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__storage_pools__subpools_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "system__task_info_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "gnat__secure_hashes_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "gnat__secure_hashes__sha2_common_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gnat__secure_hashes__sha2_64_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "system__assertions_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "system__pool_global_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "gnat__sockets_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "system__pool_size_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "ada__strings__unbounded_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "gnat__sha512_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "gnat__sockets__thin_common_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "gnat__sockets__thin_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "gnat__string_split_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "system__strings__stream_ops_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "system__tasking__initialization_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "ada__real_time_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "ada__text_io_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "system__tasking__protected_objects_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__tasking__protected_objects__entries_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "system__tasking__queuing_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "system__tasking__stages_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "client_logic_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "client_ui_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "datatypes_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "gui_to_server_communication_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "protocol_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "user_databases_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "concrete_server_logic_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "concrete_server_logic__finalize_body");
      begin
         E100 := E100 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "concrete_server_logic__finalize_spec");
      begin
         F2;
      end;
      E245 := E245 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "user_databases__finalize_spec");
      begin
         F3;
      end;
      E190 := E190 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "datatypes__finalize_spec");
      begin
         F4;
      end;
      E155 := E155 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F5;
      end;
      E179 := E179 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__text_io__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gnat__sockets__finalize_body");
      begin
         E216 := E216 - 1;
         F7;
      end;
      E044 := E044 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "ada__strings__unbounded__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__file_io__finalize_body");
      begin
         E183 := E183 - 1;
         F9;
      end;
      E075 := E075 - 1;
      E071 := E071 - 1;
      E223 := E223 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__pool_size__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gnat__sockets__finalize_spec");
      begin
         F11;
      end;
      E206 := E206 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__pool_global__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__storage_pools__subpools__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "system__finalization_masters__finalize_spec");
      begin
         F14;
      end;
      E212 := E212 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "ada__streams__stream_io__finalize_spec");
      begin
         F15;
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
      E172 := E172 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E084 := E084 + 1;
      Ada.Strings'Elab_Spec;
      E042 := E042 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E254 := E254 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E083 := E083 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E023 := E023 + 1;
      System.File_Control_Block'Elab_Spec;
      E188 := E188 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E212 := E212 + 1;
      System.Finalization_Root'Elab_Spec;
      E086 := E086 + 1;
      Ada.Finalization'Elab_Spec;
      E081 := E081 + 1;
      System.Storage_Pools'Elab_Spec;
      E088 := E088 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E128 := E128 + 1;
      E195 := E195 + 1;
      E202 := E202 + 1;
      Gnat.Secure_Hashes.Sha2_64'Elab_Spec;
      E197 := E197 + 1;
      System.Assertions'Elab_Spec;
      E204 := E204 + 1;
      System.Pool_Global'Elab_Spec;
      E206 := E206 + 1;
      Gnat.Sockets'Elab_Spec;
      System.Pool_Size'Elab_Spec;
      E223 := E223 + 1;
      E071 := E071 + 1;
      System.Finalization_Masters'Elab_Body;
      E075 := E075 + 1;
      System.File_Io'Elab_Body;
      E183 := E183 + 1;
      E112 := E112 + 1;
      E110 := E110 + 1;
      Ada.Tags'Elab_Body;
      E055 := E055 + 1;
      E048 := E048 + 1;
      System.Soft_Links'Elab_Body;
      E011 := E011 + 1;
      System.Os_Lib'Elab_Body;
      E185 := E185 + 1;
      System.Secondary_Stack'Elab_Body;
      E015 := E015 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E044 := E044 + 1;
      Gnat.Sha512'Elab_Spec;
      E193 := E193 + 1;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E221 := E221 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E219 := E219 + 1;
      Gnat.Sockets'Elab_Body;
      E216 := E216 + 1;
      Gnat.String_Split'Elab_Spec;
      E228 := E228 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E210 := E210 + 1;
      System.Tasking.Initialization'Elab_Body;
      E143 := E143 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E167 := E167 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E179 := E179 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E151 := E151 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E155 := E155 + 1;
      System.Tasking.Queuing'Elab_Body;
      E159 := E159 + 1;
      System.Tasking.Stages'Elab_Body;
      E165 := E165 + 1;
      Client_Logic'Elab_Spec;
      E096 := E096 + 1;
      E098 := E098 + 1;
      Datatypes'Elab_Spec;
      E190 := E190 + 1;
      Gui_To_Server_Communication'Elab_Spec;
      E229 := E229 + 1;
      E231 := E231 + 1;
      User_Databases'Elab_Spec;
      E245 := E245 + 1;
      Concrete_Server_Logic'Elab_Spec;
      Concrete_Server_Logic'Elab_Body;
      E100 := E100 + 1;
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
   --   C:\Users\Thomas\Documents\adachat\client_logic.o
   --   C:\Users\Thomas\Documents\adachat\client_ui.o
   --   C:\Users\Thomas\Documents\adachat\datatypes.o
   --   C:\Users\Thomas\Documents\adachat\gui_to_server_communication.o
   --   C:\Users\Thomas\Documents\adachat\protocol.o
   --   C:\Users\Thomas\Documents\adachat\user_databases.o
   --   C:\Users\Thomas\Documents\adachat\concrete_server_logic.o
   --   C:\Users\Thomas\Documents\adachat\main.o
   --   -LC:\Users\Thomas\Documents\adachat\
   --   -LC:\Users\Thomas\Documents\adachat\
   --   -LC:\GtkAda\lib\gtkada\static\
   --   -LC:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
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
