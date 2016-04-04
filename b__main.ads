pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2015 (20150428-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#fc7ec4e5#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#fbff4c67#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#f72f352b#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00005, "ada__stringsS");
   u00006 : constant Version_32 := 16#f4ce8c3a#;
   pragma Export (C, u00006, "systemS");
   u00007 : constant Version_32 := 16#393398c1#;
   pragma Export (C, u00007, "system__exception_tableB");
   u00008 : constant Version_32 := 16#5ad7ea2f#;
   pragma Export (C, u00008, "system__exception_tableS");
   u00009 : constant Version_32 := 16#a207fefe#;
   pragma Export (C, u00009, "system__soft_linksB");
   u00010 : constant Version_32 := 16#af945ded#;
   pragma Export (C, u00010, "system__soft_linksS");
   u00011 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00011, "system__parametersB");
   u00012 : constant Version_32 := 16#8ae48145#;
   pragma Export (C, u00012, "system__parametersS");
   u00013 : constant Version_32 := 16#b19b6653#;
   pragma Export (C, u00013, "system__secondary_stackB");
   u00014 : constant Version_32 := 16#5faf4353#;
   pragma Export (C, u00014, "system__secondary_stackS");
   u00015 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00015, "system__storage_elementsB");
   u00016 : constant Version_32 := 16#d90dc63e#;
   pragma Export (C, u00016, "system__storage_elementsS");
   u00017 : constant Version_32 := 16#b612ca65#;
   pragma Export (C, u00017, "ada__exceptionsB");
   u00018 : constant Version_32 := 16#1d190453#;
   pragma Export (C, u00018, "ada__exceptionsS");
   u00019 : constant Version_32 := 16#a46739c0#;
   pragma Export (C, u00019, "ada__exceptions__last_chance_handlerB");
   u00020 : constant Version_32 := 16#3aac8c92#;
   pragma Export (C, u00020, "ada__exceptions__last_chance_handlerS");
   u00021 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00021, "system__exceptionsB");
   u00022 : constant Version_32 := 16#9cade1cc#;
   pragma Export (C, u00022, "system__exceptionsS");
   u00023 : constant Version_32 := 16#37d758f1#;
   pragma Export (C, u00023, "system__exceptions__machineS");
   u00024 : constant Version_32 := 16#b895431d#;
   pragma Export (C, u00024, "system__exceptions_debugB");
   u00025 : constant Version_32 := 16#472c9584#;
   pragma Export (C, u00025, "system__exceptions_debugS");
   u00026 : constant Version_32 := 16#570325c8#;
   pragma Export (C, u00026, "system__img_intB");
   u00027 : constant Version_32 := 16#f6156cf8#;
   pragma Export (C, u00027, "system__img_intS");
   u00028 : constant Version_32 := 16#b98c3e16#;
   pragma Export (C, u00028, "system__tracebackB");
   u00029 : constant Version_32 := 16#6af355e1#;
   pragma Export (C, u00029, "system__tracebackS");
   u00030 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00030, "system__traceback_entriesB");
   u00031 : constant Version_32 := 16#f4957a4a#;
   pragma Export (C, u00031, "system__traceback_entriesS");
   u00032 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00032, "system__wch_conB");
   u00033 : constant Version_32 := 16#efb3aee8#;
   pragma Export (C, u00033, "system__wch_conS");
   u00034 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00034, "system__wch_stwB");
   u00035 : constant Version_32 := 16#c2a282e9#;
   pragma Export (C, u00035, "system__wch_stwS");
   u00036 : constant Version_32 := 16#92b797cb#;
   pragma Export (C, u00036, "system__wch_cnvB");
   u00037 : constant Version_32 := 16#e004141b#;
   pragma Export (C, u00037, "system__wch_cnvS");
   u00038 : constant Version_32 := 16#6033a23f#;
   pragma Export (C, u00038, "interfacesS");
   u00039 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00039, "system__wch_jisB");
   u00040 : constant Version_32 := 16#60740d3a#;
   pragma Export (C, u00040, "system__wch_jisS");
   u00041 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00041, "system__stack_checkingB");
   u00042 : constant Version_32 := 16#7a71e7d2#;
   pragma Export (C, u00042, "system__stack_checkingS");
   u00043 : constant Version_32 := 16#f78329ae#;
   pragma Export (C, u00043, "ada__strings__unboundedB");
   u00044 : constant Version_32 := 16#e303cf90#;
   pragma Export (C, u00044, "ada__strings__unboundedS");
   u00045 : constant Version_32 := 16#d22169ac#;
   pragma Export (C, u00045, "ada__strings__searchB");
   u00046 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00046, "ada__strings__searchS");
   u00047 : constant Version_32 := 16#e2ea8656#;
   pragma Export (C, u00047, "ada__strings__mapsB");
   u00048 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00048, "ada__strings__mapsS");
   u00049 : constant Version_32 := 16#41937159#;
   pragma Export (C, u00049, "system__bit_opsB");
   u00050 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00050, "system__bit_opsS");
   u00051 : constant Version_32 := 16#699628fa#;
   pragma Export (C, u00051, "system__unsigned_typesS");
   u00052 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00052, "ada__charactersS");
   u00053 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00053, "ada__characters__latin_1S");
   u00054 : constant Version_32 := 16#12c8cd7d#;
   pragma Export (C, u00054, "ada__tagsB");
   u00055 : constant Version_32 := 16#ce72c228#;
   pragma Export (C, u00055, "ada__tagsS");
   u00056 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00056, "system__htableB");
   u00057 : constant Version_32 := 16#700c3fd0#;
   pragma Export (C, u00057, "system__htableS");
   u00058 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00058, "system__string_hashB");
   u00059 : constant Version_32 := 16#d25254ae#;
   pragma Export (C, u00059, "system__string_hashS");
   u00060 : constant Version_32 := 16#b44f9ae7#;
   pragma Export (C, u00060, "system__val_unsB");
   u00061 : constant Version_32 := 16#793ec5c1#;
   pragma Export (C, u00061, "system__val_unsS");
   u00062 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00062, "system__val_utilB");
   u00063 : constant Version_32 := 16#586e3ac4#;
   pragma Export (C, u00063, "system__val_utilS");
   u00064 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00064, "system__case_utilB");
   u00065 : constant Version_32 := 16#d0c7e5ed#;
   pragma Export (C, u00065, "system__case_utilS");
   u00066 : constant Version_32 := 16#5b9edcc4#;
   pragma Export (C, u00066, "system__compare_array_unsigned_8B");
   u00067 : constant Version_32 := 16#5dcdfdb7#;
   pragma Export (C, u00067, "system__compare_array_unsigned_8S");
   u00068 : constant Version_32 := 16#5f72f755#;
   pragma Export (C, u00068, "system__address_operationsB");
   u00069 : constant Version_32 := 16#e7c23209#;
   pragma Export (C, u00069, "system__address_operationsS");
   u00070 : constant Version_32 := 16#6a859064#;
   pragma Export (C, u00070, "system__storage_pools__subpoolsB");
   u00071 : constant Version_32 := 16#e3b008dc#;
   pragma Export (C, u00071, "system__storage_pools__subpoolsS");
   u00072 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00072, "system__address_imageB");
   u00073 : constant Version_32 := 16#55221100#;
   pragma Export (C, u00073, "system__address_imageS");
   u00074 : constant Version_32 := 16#b5b2aca1#;
   pragma Export (C, u00074, "system__finalization_mastersB");
   u00075 : constant Version_32 := 16#80d8a57a#;
   pragma Export (C, u00075, "system__finalization_mastersS");
   u00076 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00076, "system__img_boolB");
   u00077 : constant Version_32 := 16#0117fdd1#;
   pragma Export (C, u00077, "system__img_boolS");
   u00078 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00078, "system__ioB");
   u00079 : constant Version_32 := 16#6a8c7b75#;
   pragma Export (C, u00079, "system__ioS");
   u00080 : constant Version_32 := 16#b7ab275c#;
   pragma Export (C, u00080, "ada__finalizationB");
   u00081 : constant Version_32 := 16#19f764ca#;
   pragma Export (C, u00081, "ada__finalizationS");
   u00082 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00082, "ada__streamsB");
   u00083 : constant Version_32 := 16#2e6701ab#;
   pragma Export (C, u00083, "ada__streamsS");
   u00084 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00084, "ada__io_exceptionsS");
   u00085 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00085, "system__finalization_rootB");
   u00086 : constant Version_32 := 16#bb3cffaa#;
   pragma Export (C, u00086, "system__finalization_rootS");
   u00087 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00087, "system__storage_poolsB");
   u00088 : constant Version_32 := 16#01950bbe#;
   pragma Export (C, u00088, "system__storage_poolsS");
   u00089 : constant Version_32 := 16#63f11652#;
   pragma Export (C, u00089, "system__storage_pools__subpools__finalizationB");
   u00090 : constant Version_32 := 16#fe2f4b3a#;
   pragma Export (C, u00090, "system__storage_pools__subpools__finalizationS");
   u00091 : constant Version_32 := 16#e5ac57f8#;
   pragma Export (C, u00091, "system__atomic_countersB");
   u00092 : constant Version_32 := 16#39b218f0#;
   pragma Export (C, u00092, "system__atomic_countersS");
   u00093 : constant Version_32 := 16#fb75f7f4#;
   pragma Export (C, u00093, "system__machine_codeS");
   u00094 : constant Version_32 := 16#f4e1c091#;
   pragma Export (C, u00094, "system__stream_attributesB");
   u00095 : constant Version_32 := 16#221dd20d#;
   pragma Export (C, u00095, "system__stream_attributesS");
   u00096 : constant Version_32 := 16#46084743#;
   pragma Export (C, u00096, "client_logicS");
   u00097 : constant Version_32 := 16#81548b0d#;
   pragma Export (C, u00097, "communication_objectsS");
   u00098 : constant Version_32 := 16#401d7087#;
   pragma Export (C, u00098, "client_uiB");
   u00099 : constant Version_32 := 16#80f42b28#;
   pragma Export (C, u00099, "client_uiS");
   u00100 : constant Version_32 := 16#00ff54ce#;
   pragma Export (C, u00100, "communication_objects__filesS");
   u00101 : constant Version_32 := 16#d1833866#;
   pragma Export (C, u00101, "communication_objects__messagesB");
   u00102 : constant Version_32 := 16#79d9a6ce#;
   pragma Export (C, u00102, "communication_objects__messagesS");
   u00103 : constant Version_32 := 16#06cb2950#;
   pragma Export (C, u00103, "system__strings__stream_opsB");
   u00104 : constant Version_32 := 16#55d4bd57#;
   pragma Export (C, u00104, "system__strings__stream_opsS");
   u00105 : constant Version_32 := 16#a71b0af5#;
   pragma Export (C, u00105, "ada__streams__stream_ioB");
   u00106 : constant Version_32 := 16#31fc8e02#;
   pragma Export (C, u00106, "ada__streams__stream_ioS");
   u00107 : constant Version_32 := 16#84a27f0d#;
   pragma Export (C, u00107, "interfaces__c_streamsB");
   u00108 : constant Version_32 := 16#8bb5f2c0#;
   pragma Export (C, u00108, "interfaces__c_streamsS");
   u00109 : constant Version_32 := 16#845f5a34#;
   pragma Export (C, u00109, "system__crtlS");
   u00110 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00110, "system__communicationB");
   u00111 : constant Version_32 := 16#edaed9e8#;
   pragma Export (C, u00111, "system__communicationS");
   u00112 : constant Version_32 := 16#431faf3c#;
   pragma Export (C, u00112, "system__file_ioB");
   u00113 : constant Version_32 := 16#53bf6d5f#;
   pragma Export (C, u00113, "system__file_ioS");
   u00114 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00114, "interfaces__cB");
   u00115 : constant Version_32 := 16#4a38bedb#;
   pragma Export (C, u00115, "interfaces__cS");
   u00116 : constant Version_32 := 16#ee0f26dd#;
   pragma Export (C, u00116, "system__os_libB");
   u00117 : constant Version_32 := 16#d7b69782#;
   pragma Export (C, u00117, "system__os_libS");
   u00118 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00118, "system__stringsB");
   u00119 : constant Version_32 := 16#8a719d5c#;
   pragma Export (C, u00119, "system__stringsS");
   u00120 : constant Version_32 := 16#09511692#;
   pragma Export (C, u00120, "system__file_control_blockS");
   u00121 : constant Version_32 := 16#018ebcf4#;
   pragma Export (C, u00121, "communication_objects__messages__connectB");
   u00122 : constant Version_32 := 16#734aac9e#;
   pragma Export (C, u00122, "communication_objects__messages__connectS");
   u00123 : constant Version_32 := 16#a2ec75a5#;
   pragma Export (C, u00123, "communication_objects__messages__disconnectB");
   u00124 : constant Version_32 := 16#619da8aa#;
   pragma Export (C, u00124, "communication_objects__messages__disconnectS");
   u00125 : constant Version_32 := 16#aa791357#;
   pragma Export (C, u00125, "communication_objects__messages__refuseB");
   u00126 : constant Version_32 := 16#fc5aefc5#;
   pragma Export (C, u00126, "communication_objects__messages__refuseS");
   u00127 : constant Version_32 := 16#36f20dae#;
   pragma Export (C, u00127, "communication_objects__messages__userlistB");
   u00128 : constant Version_32 := 16#70e9a888#;
   pragma Export (C, u00128, "communication_objects__messages__userlistS");
   u00129 : constant Version_32 := 16#e08522dd#;
   pragma Export (C, u00129, "data_typesB");
   u00130 : constant Version_32 := 16#68d97f1b#;
   pragma Export (C, u00130, "data_typesS");
   u00131 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00131, "ada__containersS");
   u00132 : constant Version_32 := 16#1767a79e#;
   pragma Export (C, u00132, "system__assertionsB");
   u00133 : constant Version_32 := 16#3943a0ae#;
   pragma Export (C, u00133, "system__assertionsS");
   u00134 : constant Version_32 := 16#e34550ca#;
   pragma Export (C, u00134, "system__pool_globalB");
   u00135 : constant Version_32 := 16#c88d2d16#;
   pragma Export (C, u00135, "system__pool_globalS");
   u00136 : constant Version_32 := 16#2bce1226#;
   pragma Export (C, u00136, "system__memoryB");
   u00137 : constant Version_32 := 16#adb3ea0e#;
   pragma Export (C, u00137, "system__memoryS");
   u00138 : constant Version_32 := 16#84073d23#;
   pragma Export (C, u00138, "data_types_testB");
   u00139 : constant Version_32 := 16#394a7525#;
   pragma Export (C, u00139, "data_types_testS");
   u00140 : constant Version_32 := 16#9094876d#;
   pragma Export (C, u00140, "ada__assertionsB");
   u00141 : constant Version_32 := 16#538f1e95#;
   pragma Export (C, u00141, "ada__assertionsS");
   u00142 : constant Version_32 := 16#28f088c2#;
   pragma Export (C, u00142, "ada__text_ioB");
   u00143 : constant Version_32 := 16#1a9b0017#;
   pragma Export (C, u00143, "ada__text_ioS");
   u00144 : constant Version_32 := 16#508ced14#;
   pragma Export (C, u00144, "server_logicS");
   u00145 : constant Version_32 := 16#2e6ba377#;
   pragma Export (C, u00145, "server_uiB");
   u00146 : constant Version_32 := 16#1b71642f#;
   pragma Export (C, u00146, "server_uiS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.io%s
   --  system.io%b
   --  system.machine_code%s
   --  system.atomic_counters%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.os_lib%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.unsigned_types%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  system.address_image%s
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.tags%s
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c%s
   --  system.communication%s
   --  system.communication%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.file_control_block%s
   --  ada.streams.stream_io%s
   --  system.file_io%s
   --  ada.streams.stream_io%b
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  system.assertions%s
   --  system.assertions%b
   --  ada.assertions%s
   --  ada.assertions%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.secondary_stack%s
   --  system.storage_pools.subpools%b
   --  system.finalization_masters%b
   --  system.file_io%b
   --  interfaces.c%b
   --  ada.tags%b
   --  ada.strings.maps%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.address_image%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  client_ui%s
   --  client_ui%b
   --  communication_objects%s
   --  client_logic%s
   --  communication_objects.files%s
   --  communication_objects.messages%s
   --  communication_objects.messages%b
   --  communication_objects.messages.connect%s
   --  communication_objects.messages.connect%b
   --  communication_objects.messages.disconnect%s
   --  communication_objects.messages.disconnect%b
   --  communication_objects.messages.refuse%s
   --  communication_objects.messages.refuse%b
   --  data_types%s
   --  data_types%b
   --  communication_objects.messages.userlist%s
   --  communication_objects.messages.userlist%b
   --  data_types_test%s
   --  data_types_test%b
   --  server_logic%s
   --  server_ui%s
   --  server_ui%b
   --  main%b
   --  END ELABORATION ORDER


end ada_main;
