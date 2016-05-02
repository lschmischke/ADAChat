pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

<<<<<<< HEAD
<<<<<<< HEAD
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
=======
   E185 : Short_Integer; pragma Import (Ada, E185, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "ada__containers_E");
=======
   E111 : Short_Integer; pragma Import (Ada, E111, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__soft_links_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "system__exception_table_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "ada__containers_E");
>>>>>>> origin/feature/server_logic
   E084 : Short_Integer; pragma Import (Ada, E084, "ada__io_exceptions_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__strings_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__strings__maps_E");
   E507 : Short_Integer; pragma Import (Ada, E507, "ada__strings__maps__constants_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__tags_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "ada__streams_E");
<<<<<<< HEAD
   E110 : Short_Integer; pragma Import (Ada, E110, "interfaces__c_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "interfaces__c__strings_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exceptions_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "system__file_control_block_E");
   E460 : Short_Integer; pragma Import (Ada, E460, "ada__streams__stream_io_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "system__file_io_E");
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
   E109 : Short_Integer; pragma Import (Ada, E109, "interfaces__c_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "interfaces__c__strings_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "system__exceptions_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "system__file_control_block_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "ada__streams__stream_io_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "system__file_io_E");
>>>>>>> origin/feature/server_logic
   E086 : Short_Integer; pragma Import (Ada, E086, "system__finalization_root_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "ada__finalization_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__storage_pools_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__finalization_masters_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__storage_pools__subpools_E");
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
   E128 : Short_Integer; pragma Import (Ada, E128, "system__task_info_E");
   E506 : Short_Integer; pragma Import (Ada, E506, "gnat__secure_hashes_E");
   E513 : Short_Integer; pragma Import (Ada, E513, "gnat__secure_hashes__sha2_common_E");
   E508 : Short_Integer; pragma Import (Ada, E508, "gnat__secure_hashes__sha2_64_E");
   E453 : Short_Integer; pragma Import (Ada, E453, "system__assertions_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "system__pool_global_E");
   E480 : Short_Integer; pragma Import (Ada, E480, "gnat__sockets_E");
   E487 : Short_Integer; pragma Import (Ada, E487, "system__pool_size_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
=======
   E441 : Short_Integer; pragma Import (Ada, E441, "system__task_info_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "gnat__secure_hashes_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "gnat__secure_hashes__sha2_common_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "gnat__secure_hashes__sha2_64_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__assertions_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "system__pool_global_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "gnat__sockets_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__pool_size_E");
   E014 : Short_Integer; pragma Import (Ada, E014, "system__secondary_stack_E");
>>>>>>> origin/feature/server_logic
   E044 : Short_Integer; pragma Import (Ada, E044, "ada__strings__unbounded_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "gnat__sha512_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "gnat__sockets__thin_common_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "gnat__sockets__thin_E");
   E490 : Short_Integer; pragma Import (Ada, E490, "gnat__string_split_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__strings__stream_ops_E");
   E455 : Short_Integer; pragma Import (Ada, E455, "system__tasking__initialization_E");
   E479 : Short_Integer; pragma Import (Ada, E479, "ada__real_time_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "ada__text_io_E");
   E463 : Short_Integer; pragma Import (Ada, E463, "system__tasking__protected_objects_E");
   E467 : Short_Integer; pragma Import (Ada, E467, "system__tasking__protected_objects__entries_E");
   E471 : Short_Integer; pragma Import (Ada, E471, "system__tasking__queuing_E");
   E477 : Short_Integer; pragma Import (Ada, E477, "system__tasking__stages_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "glib_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "gtkada__types_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "client_logic_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "client_ui_E");
<<<<<<< HEAD
   E502 : Short_Integer; pragma Import (Ada, E502, "datatypes_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "gdk__frame_timings_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "glib__glist_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "gdk__visual_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "glib__gslist_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "glib__key_file_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "glib__object_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "glib__string_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "glib__type_conversion_hooks_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "glib__types_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "glib__g_icon_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "glib__values_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "cairo_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "cairo__region_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "gdk__color_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "gdk__rectangle_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "gdk__rgba_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "glib__generic_properties_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "gtk__editable_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "gtkada__c_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "gtkada__bindings_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "gdk__frame_clock_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "gdk__types_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "gdk__event_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gdk__display_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "gdk__pixbuf_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "glib__properties_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "gdk__screen_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "gdk__device_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "gdk__drag_contexts_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "gdk__window_E");
   E383 : Short_Integer; pragma Import (Ada, E383, "glib__variant_E");
   E411 : Short_Integer; pragma Import (Ada, E411, "glib__menu_model_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "gtk__accel_group_E");
   E389 : Short_Integer; pragma Import (Ada, E389, "gtk__actionable_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "gtk__adjustment_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "gtk__builder_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "gtk__buildable_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "gtk__cell_area_context_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "gtk__cell_editable_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "gtk__css_section_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "gtk__entry_buffer_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "gtk__enums_E");
   E343 : Short_Integer; pragma Import (Ada, E343, "gtk__icon_source_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "gtk__orientable_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "gtk__paper_size_E");
   E361 : Short_Integer; pragma Import (Ada, E361, "gtk__page_setup_E");
   E373 : Short_Integer; pragma Import (Ada, E373, "gtk__print_settings_E");
   E427 : Short_Integer; pragma Import (Ada, E427, "gtk__scrollable_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "gtk__selection_data_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "gtk__style_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "gtk__target_entry_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "gtk__target_list_E");
   E431 : Short_Integer; pragma Import (Ada, E431, "gtk__clipboard_E");
   E435 : Short_Integer; pragma Import (Ada, E435, "gtk__text_mark_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "gtk__tree_model_E");
   E401 : Short_Integer; pragma Import (Ada, E401, "gtk__tree_drag_dest_E");
   E403 : Short_Integer; pragma Import (Ada, E403, "gtk__tree_drag_source_E");
   E405 : Short_Integer; pragma Import (Ada, E405, "gtk__tree_sortable_E");
   E399 : Short_Integer; pragma Import (Ada, E399, "gtk__list_store_E");
   E441 : Short_Integer; pragma Import (Ada, E441, "gtk__tree_store_E");
   E449 : Short_Integer; pragma Import (Ada, E449, "gtkada__builder_E");
   E514 : Short_Integer; pragma Import (Ada, E514, "gui_to_server_communication_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "pango__enums_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "pango__attributes_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "pango__font_metrics_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "pango__language_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "pango__font_E");
   E379 : Short_Integer; pragma Import (Ada, E379, "gtk__text_attributes_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "gtk__text_tag_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "gtk__text_iter_E");
   E437 : Short_Integer; pragma Import (Ada, E437, "gtk__text_tag_table_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "pango__font_face_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "pango__font_family_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "pango__fontset_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "pango__matrix_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "pango__context_E");
   E369 : Short_Integer; pragma Import (Ada, E369, "pango__font_map_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "pango__tabs_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "pango__layout_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "gtk__print_context_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "gtk__print_operation_preview_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "gtk__widget_E");
   E387 : Short_Integer; pragma Import (Ada, E387, "gtk__action_E");
   E391 : Short_Integer; pragma Import (Ada, E391, "gtk__activatable_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "gtk__cell_renderer_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "gtk__cell_layout_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "gtk__cell_area_E");
   E393 : Short_Integer; pragma Import (Ada, E393, "gtk__cell_renderer_text_E");
   E395 : Short_Integer; pragma Import (Ada, E395, "gtk__cell_renderer_toggle_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "gtk__container_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "gtk__bin_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "gtk__box_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "gtk__button_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "gtk__entry_completion_E");
   E397 : Short_Integer; pragma Import (Ada, E397, "gtk__frame_E");
   E421 : Short_Integer; pragma Import (Ada, E421, "gtk__grange_E");
   E407 : Short_Integer; pragma Import (Ada, E407, "gtk__main_E");
   E455 : Short_Integer; pragma Import (Ada, E455, "gtk__marshallers_E");
   E413 : Short_Integer; pragma Import (Ada, E413, "gtk__menu_item_E");
   E415 : Short_Integer; pragma Import (Ada, E415, "gtk__menu_shell_E");
   E409 : Short_Integer; pragma Import (Ada, E409, "gtk__menu_E");
   E351 : Short_Integer; pragma Import (Ada, E351, "gtk__misc_E");
   E357 : Short_Integer; pragma Import (Ada, E357, "gtk__notebook_E");
   E419 : Short_Integer; pragma Import (Ada, E419, "gtk__scrollbar_E");
   E417 : Short_Integer; pragma Import (Ada, E417, "gtk__scrolled_window_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "gtk__status_bar_E");
   E349 : Short_Integer; pragma Import (Ada, E349, "gtk__style_provider_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "gtk__style_context_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "gtk__icon_set_E");
   E339 : Short_Integer; pragma Import (Ada, E339, "gtk__image_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "gtk__gentry_E");
   E423 : Short_Integer; pragma Import (Ada, E423, "gtk__spin_button_E");
   E433 : Short_Integer; pragma Import (Ada, E433, "gtk__text_child_anchor_E");
   E429 : Short_Integer; pragma Import (Ada, E429, "gtk__text_buffer_E");
   E425 : Short_Integer; pragma Import (Ada, E425, "gtk__text_view_E");
   E445 : Short_Integer; pragma Import (Ada, E445, "gtk__tooltip_E");
   E439 : Short_Integer; pragma Import (Ada, E439, "gtk__tree_selection_E");
   E447 : Short_Integer; pragma Import (Ada, E447, "gtk__tree_view_column_E");
   E443 : Short_Integer; pragma Import (Ada, E443, "gtk__tree_view_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "gtk__window_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "gtk__dialog_E");
   E359 : Short_Integer; pragma Import (Ada, E359, "gtk__print_operation_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "gtk__arguments_E");
   E456 : Short_Integer; pragma Import (Ada, E456, "gtkada__handlers_E");
   E464 : Short_Integer; pragma Import (Ada, E464, "protocol_E");
   E516 : Short_Integer; pragma Import (Ada, E516, "user_databases_E");
   E491 : Short_Integer; pragma Import (Ada, E491, "server_to_gui_communication_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "concrete_server_logic_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "concrete_server_gui_logic_E");
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
   E118 : Short_Integer; pragma Import (Ada, E118, "datatypes_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "gdk__frame_timings_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "glib__glist_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "gdk__visual_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "glib__gslist_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "glib__key_file_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "glib__object_E");
   E349 : Short_Integer; pragma Import (Ada, E349, "glib__string_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "glib__type_conversion_hooks_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "glib__types_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "glib__g_icon_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "glib__values_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "cairo_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "cairo__region_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "gdk__color_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gdk__rectangle_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "gdk__rgba_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "glib__generic_properties_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "gtk__editable_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "gtkada__c_E");
   E168 : Short_Integer; pragma Import (Ada, E168, "gtkada__bindings_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "gdk__frame_clock_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "gdk__types_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "gdk__event_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "gdk__display_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "gdk__pixbuf_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "glib__properties_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "gdk__screen_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "gdk__device_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "gdk__drag_contexts_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "gdk__window_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "glib__variant_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "glib__menu_model_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "gtk__accel_group_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "gtk__actionable_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "gtk__adjustment_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "gtk__builder_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "gtk__buildable_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "gtk__cell_area_context_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "gtk__cell_editable_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "gtk__css_section_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "gtk__entry_buffer_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "gtk__enums_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "gtk__icon_source_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "gtk__orientable_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "gtk__paper_size_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "gtk__page_setup_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "gtk__print_settings_E");
   E391 : Short_Integer; pragma Import (Ada, E391, "gtk__scrollable_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gtk__selection_data_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "gtk__style_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "gtk__target_entry_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "gtk__target_list_E");
   E395 : Short_Integer; pragma Import (Ada, E395, "gtk__clipboard_E");
   E399 : Short_Integer; pragma Import (Ada, E399, "gtk__text_mark_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "gtk__tree_model_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "gtk__tree_drag_dest_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "gtk__tree_drag_source_E");
   E369 : Short_Integer; pragma Import (Ada, E369, "gtk__tree_sortable_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "gtk__list_store_E");
   E405 : Short_Integer; pragma Import (Ada, E405, "gtk__tree_store_E");
   E519 : Short_Integer; pragma Import (Ada, E519, "gtkada__builder_E");
   E491 : Short_Integer; pragma Import (Ada, E491, "gui_to_server_communication_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "pango__enums_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "pango__attributes_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "pango__font_metrics_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "pango__language_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "pango__font_E");
   E343 : Short_Integer; pragma Import (Ada, E343, "gtk__text_attributes_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "gtk__text_tag_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "gtk__text_iter_E");
   E401 : Short_Integer; pragma Import (Ada, E401, "gtk__text_tag_table_E");
   E261 : Short_Integer; pragma Import (Ada, E261, "pango__font_face_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "pango__font_family_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "pango__fontset_E");
   E265 : Short_Integer; pragma Import (Ada, E265, "pango__matrix_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "pango__context_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "pango__font_map_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "pango__tabs_E");
   E267 : Short_Integer; pragma Import (Ada, E267, "pango__layout_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "gtk__print_context_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "gtk__print_operation_preview_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "gtk__widget_E");
   E351 : Short_Integer; pragma Import (Ada, E351, "gtk__action_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "gtk__activatable_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "gtk__cell_renderer_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "gtk__cell_layout_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "gtk__cell_area_E");
   E357 : Short_Integer; pragma Import (Ada, E357, "gtk__cell_renderer_text_E");
   E359 : Short_Integer; pragma Import (Ada, E359, "gtk__cell_renderer_toggle_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "gtk__container_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "gtk__bin_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "gtk__box_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "gtk__button_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "gtk__entry_completion_E");
   E361 : Short_Integer; pragma Import (Ada, E361, "gtk__frame_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "gtk__grange_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "gtk__main_E");
   E523 : Short_Integer; pragma Import (Ada, E523, "gtk__marshallers_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "gtk__menu_item_E");
   E379 : Short_Integer; pragma Import (Ada, E379, "gtk__menu_shell_E");
   E373 : Short_Integer; pragma Import (Ada, E373, "gtk__menu_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "gtk__misc_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "gtk__notebook_E");
   E383 : Short_Integer; pragma Import (Ada, E383, "gtk__scrollbar_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "gtk__scrolled_window_E");
   E532 : Short_Integer; pragma Import (Ada, E532, "gtk__size_group_E");
   E339 : Short_Integer; pragma Import (Ada, E339, "gtk__status_bar_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "gtk__style_provider_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "gtk__style_context_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "gtk__icon_set_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "gtk__image_E");
   E281 : Short_Integer; pragma Import (Ada, E281, "gtk__gentry_E");
   E387 : Short_Integer; pragma Import (Ada, E387, "gtk__spin_button_E");
   E397 : Short_Integer; pragma Import (Ada, E397, "gtk__text_child_anchor_E");
   E393 : Short_Integer; pragma Import (Ada, E393, "gtk__text_buffer_E");
   E389 : Short_Integer; pragma Import (Ada, E389, "gtk__text_view_E");
   E530 : Short_Integer; pragma Import (Ada, E530, "gtk__tool_item_E");
   E528 : Short_Integer; pragma Import (Ada, E528, "gtk__tool_button_E");
   E409 : Short_Integer; pragma Import (Ada, E409, "gtk__tooltip_E");
   E403 : Short_Integer; pragma Import (Ada, E403, "gtk__tree_selection_E");
   E411 : Short_Integer; pragma Import (Ada, E411, "gtk__tree_view_column_E");
   E407 : Short_Integer; pragma Import (Ada, E407, "gtk__tree_view_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "gtk__window_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "gtk__dialog_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "gtk__print_operation_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "gtk__arguments_E");
   E524 : Short_Integer; pragma Import (Ada, E524, "gtkada__handlers_E");
   E493 : Short_Integer; pragma Import (Ada, E493, "protocol_E");
   E526 : Short_Integer; pragma Import (Ada, E526, "serverguicallbacks_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "serverguientrypoint_E");
   E511 : Short_Integer; pragma Import (Ada, E511, "user_databases_E");
   E500 : Short_Integer; pragma Import (Ada, E500, "server_to_gui_communication_E");
   E417 : Short_Integer; pragma Import (Ada, E417, "concrete_server_logic_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "concrete_server_gui_logic_E");
>>>>>>> origin/feature/server_logic

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
<<<<<<< HEAD
<<<<<<< HEAD
      declare
         procedure F1;
         pragma Import (Ada, F1, "concrete_server_logic__finalize_body");
      begin
         E191 := E191 - 1;
=======
      E190 := E190 - 1;
=======
>>>>>>> origin/feature/server_logic
      declare
         procedure F1;
         pragma Import (Ada, F1, "concrete_server_logic__finalize_body");
      begin
<<<<<<< HEAD
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
         E417 := E417 - 1;
>>>>>>> origin/feature/server_logic
         F1;
      end;
      E116 := E116 - 1;
      declare
         procedure F2;
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
         pragma Import (Ada, F2, "concrete_server_logic__finalize_body");
=======
         pragma Import (Ada, F2, "concrete_server_gui_logic__finalize_spec");
>>>>>>> origin/feature/server_logic
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "concrete_server_logic__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "server_to_gui_communication__finalize_spec");
      begin
         E500 := E500 - 1;
         F4;
      end;
      E511 := E511 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "user_databases__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gtkada__builder__finalize_body");
      begin
         E519 := E519 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtkada__handlers__finalize_spec");
      begin
         E524 := E524 - 1;
         F7;
      end;
      E236 := E236 - 1;
      E208 := E208 - 1;
      E375 := E375 - 1;
      E242 := E242 - 1;
      E224 := E224 - 1;
      E289 := E289 - 1;
      E246 := E246 - 1;
      E395 := E395 - 1;
      E301 := E301 - 1;
      E401 := E401 - 1;
      E228 := E228 - 1;
      E351 := E351 - 1;
      E299 := E299 - 1;
      E293 := E293 - 1;
      E357 := E357 - 1;
      E359 := E359 - 1;
      E222 := E222 - 1;
      E186 := E186 - 1;
      E291 := E291 - 1;
      E385 := E385 - 1;
      E377 := E377 - 1;
      E379 := E379 - 1;
      E373 := E373 - 1;
      E321 := E321 - 1;
      E381 := E381 - 1;
      E339 := E339 - 1;
      E309 := E309 - 1;
      E281 := E281 - 1;
      E387 := E387 - 1;
      E393 := E393 - 1;
      E389 := E389 - 1;
      E530 := E530 - 1;
      E528 := E528 - 1;
      E403 := E403 - 1;
      E411 := E411 - 1;
      E407 := E407 - 1;
      E275 := E275 - 1;
      E204 := E204 - 1;
      E323 := E323 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gtk__print_operation__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "gtk__dialog__finalize_spec");
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
      begin
         F9;
      end;
      declare
         procedure F10;
<<<<<<< HEAD
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
=======
         pragma Import (Ada, F10, "gtk__window__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gtk__tree_view__finalize_spec");
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
      begin
         F11;
      end;
      declare
         procedure F12;
<<<<<<< HEAD
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
=======
         pragma Import (Ada, F12, "gtk__tree_view_column__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtk__tree_selection__finalize_spec");
      begin
         F13;
      end;
      E409 := E409 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__tooltip__finalize_spec");
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
      begin
         F14;
      end;
      declare
         procedure F15;
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
         pragma Import (Ada, F15, "gtk__text_view__finalize_spec");
=======
         pragma Import (Ada, F15, "gtk__tool_button__finalize_spec");
>>>>>>> origin/feature/server_logic
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__tool_item__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__text_view__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__text_buffer__finalize_spec");
      begin
         F18;
      end;
      E397 := E397 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__text_child_anchor__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__spin_button__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__gentry__finalize_spec");
      begin
         F21;
      end;
      E303 := E303 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__image__finalize_spec");
      begin
         F22;
      end;
      E305 := E305 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__icon_set__finalize_spec");
      begin
         F23;
      end;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__style_context__finalize_spec");
      begin
         F24;
      end;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__status_bar__finalize_spec");
      begin
         F25;
      end;
      E532 := E532 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__size_group__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__scrolled_window__finalize_spec");
      begin
         F27;
      end;
      E383 := E383 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__scrollbar__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__notebook__finalize_spec");
      begin
         F29;
      end;
      E315 := E315 - 1;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__misc__finalize_spec");
      begin
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__menu__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__menu_shell__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__menu_item__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__grange__finalize_spec");
      begin
         F34;
      end;
      E361 := E361 - 1;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__frame__finalize_spec");
      begin
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gtk__entry_completion__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gtk__button__finalize_spec");
      begin
         F37;
      end;
      E214 := E214 - 1;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__box__finalize_spec");
      begin
         F38;
      end;
      E279 := E279 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__bin__finalize_spec");
      begin
         F39;
      end;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gtk__container__finalize_spec");
      begin
         F40;
      end;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gtk__cell_renderer_toggle__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__cell_renderer_text__finalize_spec");
      begin
         F42;
      end;
      declare
         procedure F43;
         pragma Import (Ada, F43, "gtk__cell_area__finalize_spec");
      begin
         F43;
      end;
      declare
         procedure F44;
         pragma Import (Ada, F44, "gtk__cell_renderer__finalize_spec");
      begin
         F44;
      end;
      declare
         procedure F45;
         pragma Import (Ada, F45, "gtk__action__finalize_spec");
      begin
         F45;
      end;
      declare
         procedure F46;
         pragma Import (Ada, F46, "gtk__widget__finalize_spec");
      begin
         F46;
      end;
      E331 := E331 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "gtk__print_context__finalize_spec");
      begin
         F47;
      end;
      E267 := E267 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "pango__layout__finalize_spec");
      begin
         F48;
      end;
      E271 := E271 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "pango__tabs__finalize_spec");
      begin
         F49;
      end;
      E333 := E333 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "pango__font_map__finalize_spec");
      begin
         F50;
      end;
      E249 := E249 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "pango__context__finalize_spec");
      begin
         F51;
      end;
      E263 := E263 - 1;
      declare
         procedure F52;
         pragma Import (Ada, F52, "pango__fontset__finalize_spec");
      begin
         F52;
      end;
      E259 := E259 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "pango__font_family__finalize_spec");
      begin
         F53;
      end;
      E261 := E261 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "pango__font_face__finalize_spec");
      begin
         F54;
      end;
      declare
         procedure F55;
         pragma Import (Ada, F55, "gtk__text_tag_table__finalize_spec");
      begin
         F55;
      end;
      E345 := E345 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "gtk__text_tag__finalize_spec");
      begin
         F56;
      end;
      E253 := E253 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "pango__font__finalize_spec");
      begin
         F57;
      end;
      E257 := E257 - 1;
      declare
         procedure F58;
         pragma Import (Ada, F58, "pango__language__finalize_spec");
      begin
         F58;
      end;
      E255 := E255 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "pango__font_metrics__finalize_spec");
      begin
         F59;
      end;
      E269 := E269 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "pango__attributes__finalize_spec");
      begin
         F60;
      end;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gui_to_server_communication__finalize_spec");
      begin
         E491 := E491 - 1;
         F61;
      end;
      declare
         procedure F62;
         pragma Import (Ada, F62, "gtkada__builder__finalize_spec");
      begin
         F62;
      end;
      E405 := E405 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "gtk__tree_store__finalize_spec");
      begin
         F63;
      end;
      E363 := E363 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "gtk__list_store__finalize_spec");
      begin
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "gtk__tree_model__finalize_spec");
      begin
         F65;
      end;
      E399 := E399 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "gtk__text_mark__finalize_spec");
      begin
         F66;
      end;
      declare
         procedure F67;
         pragma Import (Ada, F67, "gtk__clipboard__finalize_spec");
      begin
         F67;
      end;
      E317 := E317 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "gtk__target_list__finalize_spec");
      begin
         F68;
      end;
      declare
         procedure F69;
         pragma Import (Ada, F69, "gtk__style__finalize_spec");
      begin
         F69;
      end;
      E244 := E244 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "gtk__selection_data__finalize_spec");
      begin
         F70;
      end;
      E337 := E337 - 1;
      declare
         procedure F71;
         pragma Import (Ada, F71, "gtk__print_settings__finalize_spec");
      begin
         F71;
      end;
      E325 := E325 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "gtk__page_setup__finalize_spec");
      begin
         F72;
      end;
      E329 := E329 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "gtk__paper_size__finalize_spec");
      begin
         F73;
      end;
      E307 := E307 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "gtk__icon_source__finalize_spec");
      begin
         F74;
      end;
      declare
         procedure F75;
         pragma Import (Ada, F75, "gtk__entry_buffer__finalize_spec");
      begin
         F75;
      end;
      E311 := E311 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "gtk__css_section__finalize_spec");
      begin
         F76;
      end;
      E295 := E295 - 1;
      declare
         procedure F77;
         pragma Import (Ada, F77, "gtk__cell_area_context__finalize_spec");
      begin
         F77;
      end;
      E218 := E218 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "gtk__builder__finalize_spec");
      begin
         F78;
      end;
      declare
         procedure F79;
         pragma Import (Ada, F79, "gtk__adjustment__finalize_spec");
      begin
         F79;
      end;
      declare
         procedure F80;
         pragma Import (Ada, F80, "gtk__accel_group__finalize_spec");
      begin
         F80;
      end;
      declare
         procedure F81;
         pragma Import (Ada, F81, "glib__menu_model__finalize_spec");
      begin
         F81;
      end;
      E347 := E347 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "glib__variant__finalize_spec");
      begin
         F82;
      end;
      E234 := E234 - 1;
      declare
         procedure F83;
         pragma Import (Ada, F83, "gdk__drag_contexts__finalize_spec");
      begin
         F83;
      end;
      E232 := E232 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "gdk__device__finalize_spec");
      begin
         F84;
      end;
      E206 := E206 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "gdk__screen__finalize_spec");
      begin
         F85;
      end;
      E240 := E240 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "gdk__pixbuf__finalize_spec");
      begin
         F86;
      end;
      declare
         procedure F87;
         pragma Import (Ada, F87, "gdk__display__finalize_spec");
      begin
         F87;
      end;
      declare
         procedure F88;
         pragma Import (Ada, F88, "gdk__frame_clock__finalize_spec");
      begin
         F88;
      end;
      E163 := E163 - 1;
      declare
         procedure F89;
         pragma Import (Ada, F89, "glib__object__finalize_spec");
      begin
         F89;
      end;
      E238 := E238 - 1;
      declare
         procedure F90;
         pragma Import (Ada, F90, "gdk__frame_timings__finalize_spec");
      begin
         F90;
      end;
      E118 := E118 - 1;
      declare
         procedure F91;
         pragma Import (Ada, F91, "datatypes__finalize_spec");
      begin
         F91;
      end;
      E161 := E161 - 1;
      declare
         procedure F92;
         pragma Import (Ada, F92, "glib__finalize_spec");
      begin
         F92;
      end;
      E467 := E467 - 1;
      declare
         procedure F93;
         pragma Import (Ada, F93, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F93;
      end;
      E102 := E102 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "ada__text_io__finalize_spec");
      begin
         F94;
      end;
      declare
         procedure F95;
         pragma Import (Ada, F95, "gnat__sockets__finalize_body");
      begin
         E133 := E133 - 1;
         F95;
      end;
      E044 := E044 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "ada__strings__unbounded__finalize_spec");
      begin
         F96;
      end;
      declare
         procedure F97;
         pragma Import (Ada, F97, "system__file_io__finalize_body");
      begin
         E107 := E107 - 1;
         F97;
      end;
      E075 := E075 - 1;
      E071 := E071 - 1;
      E144 := E144 - 1;
      declare
         procedure F98;
         pragma Import (Ada, F98, "system__pool_size__finalize_spec");
      begin
         F98;
      end;
      declare
         procedure F99;
         pragma Import (Ada, F99, "gnat__sockets__finalize_spec");
      begin
         F99;
      end;
<<<<<<< HEAD
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E151 := E151 - 1;
      declare
         procedure F100;
         pragma Import (Ada, F100, "system__pool_global__finalize_spec");
      begin
         F100;
      end;
      declare
         procedure F101;
         pragma Import (Ada, F101, "system__storage_pools__subpools__finalize_spec");
      begin
         F101;
      end;
      declare
         procedure F102;
         pragma Import (Ada, F102, "system__finalization_masters__finalize_spec");
      begin
         F102;
      end;
      E159 := E159 - 1;
      declare
         procedure F103;
         pragma Import (Ada, F103, "ada__streams__stream_io__finalize_spec");
      begin
         F103;
      end;
>>>>>>> origin/feature/server_logic
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
<<<<<<< HEAD
           False, True, True, True, True, False, False, True, 
=======
           False, True, True, True, True, False, True, True, 
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
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
      E008 := E008 + 1;
      Ada.Containers'Elab_Spec;
<<<<<<< HEAD
<<<<<<< HEAD
      E101 := E101 + 1;
=======
      E172 := E172 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E119 := E119 + 1;
>>>>>>> origin/feature/server_logic
      Ada.Io_Exceptions'Elab_Spec;
      E084 := E084 + 1;
      Ada.Strings'Elab_Spec;
      E005 := E005 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
<<<<<<< HEAD
<<<<<<< HEAD
      E111 := E111 + 1;
=======
      E498 := E498 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E507 := E507 + 1;
>>>>>>> origin/feature/server_logic
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E083 := E083 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E022 := E022 + 1;
      System.File_Control_Block'Elab_Spec;
<<<<<<< HEAD
<<<<<<< HEAD
      E127 := E127 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E150 := E150 + 1;
=======
      E188 := E188 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E460 := E460 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E114 := E114 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E159 := E159 + 1;
>>>>>>> origin/feature/server_logic
      System.Finalization_Root'Elab_Spec;
      E086 := E086 + 1;
      Ada.Finalization'Elab_Spec;
      E081 := E081 + 1;
      System.Storage_Pools'Elab_Spec;
      E088 := E088 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
      E128 := E128 + 1;
      E506 := E506 + 1;
      E513 := E513 + 1;
=======
      E441 := E441 + 1;
      E124 := E124 + 1;
      E131 := E131 + 1;
>>>>>>> origin/feature/server_logic
      Gnat.Secure_Hashes.Sha2_64'Elab_Spec;
      E126 := E126 + 1;
      System.Assertions'Elab_Spec;
      E155 := E155 + 1;
      System.Pool_Global'Elab_Spec;
      E151 := E151 + 1;
      Gnat.Sockets'Elab_Spec;
      System.Pool_Size'Elab_Spec;
<<<<<<< HEAD
      E487 := E487 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E144 := E144 + 1;
>>>>>>> origin/feature/server_logic
      E071 := E071 + 1;
      System.Finalization_Masters'Elab_Body;
      E075 := E075 + 1;
      System.File_Io'Elab_Body;
<<<<<<< HEAD
<<<<<<< HEAD
      E120 := E120 + 1;
      E159 := E159 + 1;
      E122 := E122 + 1;
=======
      E183 := E183 + 1;
      E112 := E112 + 1;
      E110 := E110 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E107 := E107 + 1;
      E138 := E138 + 1;
      E109 := E109 + 1;
>>>>>>> origin/feature/server_logic
      Ada.Tags'Elab_Body;
      E055 := E055 + 1;
      E048 := E048 + 1;
      System.Soft_Links'Elab_Body;
      E010 := E010 + 1;
      System.Os_Lib'Elab_Body;
<<<<<<< HEAD
<<<<<<< HEAD
      E124 := E124 + 1;
=======
      E185 := E185 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E111 := E111 + 1;
>>>>>>> origin/feature/server_logic
      System.Secondary_Stack'Elab_Body;
      E014 := E014 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E044 := E044 + 1;
      Gnat.Sha512'Elab_Spec;
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
      E504 := E504 + 1;
=======
      E122 := E122 + 1;
>>>>>>> origin/feature/server_logic
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E140 := E140 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E136 := E136 + 1;
      Gnat.Sockets'Elab_Body;
      E133 := E133 + 1;
      Gnat.String_Split'Elab_Spec;
      E490 := E490 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E157 := E157 + 1;
      System.Tasking.Initialization'Elab_Body;
      E455 := E455 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E479 := E479 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E102 := E102 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E463 := E463 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E467 := E467 + 1;
      System.Tasking.Queuing'Elab_Body;
      E471 := E471 + 1;
      System.Tasking.Stages'Elab_Body;
      E477 := E477 + 1;
      Glib'Elab_Spec;
      E161 := E161 + 1;
      Gtkada.Types'Elab_Spec;
      E179 := E179 + 1;
      Client_Logic'Elab_Spec;
      E096 := E096 + 1;
      E098 := E098 + 1;
      Datatypes'Elab_Spec;
      E118 := E118 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      E238 := E238 + 1;
      E181 := E181 + 1;
      Gdk.Visual'Elab_Spec;
      Gdk.Visual'Elab_Body;
      E210 := E210 + 1;
      E183 := E183 + 1;
      Glib.Object'Elab_Spec;
      E165 := E165 + 1;
      Glib.Values'Elab_Body;
      E175 := E175 + 1;
      E190 := E190 + 1;
      E192 := E192 + 1;
      Gdk.Color'Elab_Spec;
      E197 := E197 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E200 := E200 + 1;
      E177 := E177 + 1;
      Gtkada.Bindings'Elab_Spec;
      E168 := E168 + 1;
      E283 := E283 + 1;
      E173 := E173 + 1;
      E349 := E349 + 1;
      Glib.Object'Elab_Body;
      E163 := E163 + 1;
      Gdk.Rgba'Elab_Body;
      E202 := E202 + 1;
      Gdk.Color'Elab_Body;
      E230 := E230 + 1;
      E327 := E327 + 1;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Types'Elab_Spec;
      E198 := E198 + 1;
      Gdk.Event'Elab_Spec;
      E195 := E195 + 1;
      Gdk.Display'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      E240 := E240 + 1;
      Glib.Properties'Elab_Spec;
      E212 := E212 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E206 := E206 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Device'Elab_Body;
      E232 := E232 + 1;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E234 := E234 + 1;
      Gdk.Window'Elab_Spec;
      E277 := E277 + 1;
      Glib.Variant'Elab_Spec;
      E347 := E347 + 1;
      Glib.Menu_Model'Elab_Spec;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Actionable'Elab_Spec;
      E353 := E353 + 1;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E218 := E218 + 1;
      E216 := E216 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E295 := E295 + 1;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Css_Section'Elab_Spec;
      E311 := E311 + 1;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Enums'Elab_Spec;
      E226 := E226 + 1;
      Gtk.Icon_Source'Elab_Spec;
      E307 := E307 + 1;
      Gtk.Orientable'Elab_Spec;
      E273 := E273 + 1;
      Gtk.Paper_Size'Elab_Spec;
      E329 := E329 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E325 := E325 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E337 := E337 + 1;
      Gtk.Scrollable'Elab_Spec;
      E391 := E391 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E244 := E244 + 1;
      Gtk.Style'Elab_Spec;
      E319 := E319 + 1;
      Gtk.Target_List'Elab_Spec;
      E317 := E317 + 1;
      Gtk.Clipboard'Elab_Spec;
      Gtk.Text_Mark'Elab_Spec;
      Gtk.Text_Mark'Elab_Body;
      E399 := E399 + 1;
      Gtk.Tree_Model'Elab_Spec;
      E365 := E365 + 1;
      E367 := E367 + 1;
      Gtk.List_Store'Elab_Spec;
      Gtk.List_Store'Elab_Body;
      E363 := E363 + 1;
      Gtk.Tree_Store'Elab_Spec;
      Gtk.Tree_Store'Elab_Body;
      E405 := E405 + 1;
      Gtkada.Builder'Elab_Spec;
      Gui_To_Server_Communication'Elab_Spec;
      E491 := E491 + 1;
      Pango.Enums'Elab_Spec;
      E251 := E251 + 1;
      Pango.Attributes'Elab_Spec;
      E269 := E269 + 1;
      Pango.Font_Metrics'Elab_Spec;
      E255 := E255 + 1;
      Pango.Language'Elab_Spec;
      E257 := E257 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E253 := E253 + 1;
      E343 := E343 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E345 := E345 + 1;
      Gtk.Text_Iter'Elab_Spec;
      E341 := E341 + 1;
      Gtk.Text_Tag_Table'Elab_Spec;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E261 := E261 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E259 := E259 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E263 := E263 + 1;
      E265 := E265 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E249 := E249 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E333 := E333 + 1;
      Pango.Tabs'Elab_Spec;
      E271 := E271 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E267 := E267 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E331 := E331 + 1;
      Gtk.Widget'Elab_Spec;
      Gtk.Action'Elab_Spec;
      Gtk.Activatable'Elab_Spec;
      E355 := E355 + 1;
      Gtk.Cell_Renderer'Elab_Spec;
      E297 := E297 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Cell_Renderer_Text'Elab_Spec;
      Gtk.Cell_Renderer_Toggle'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E279 := E279 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E214 := E214 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Frame'Elab_Spec;
      Gtk.Frame'Elab_Body;
      E361 := E361 + 1;
      Gtk.Grange'Elab_Spec;
      E371 := E371 + 1;
      E523 := E523 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E315 := E315 + 1;
      Gtk.Notebook'Elab_Spec;
      Gtk.Scrollbar'Elab_Spec;
      Gtk.Scrollbar'Elab_Body;
      E383 := E383 + 1;
      Gtk.Scrolled_Window'Elab_Spec;
      Gtk.Size_Group'Elab_Spec;
      Gtk.Size_Group'Elab_Body;
      E532 := E532 + 1;
      Gtk.Status_Bar'Elab_Spec;
      E313 := E313 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      E305 := E305 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E303 := E303 + 1;
      Gtk.Gentry'Elab_Spec;
      Gtk.Spin_Button'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Body;
      E397 := E397 + 1;
      Gtk.Text_Buffer'Elab_Spec;
      Gtk.Text_View'Elab_Spec;
      Gtk.Tool_Item'Elab_Spec;
      Gtk.Tool_Button'Elab_Spec;
      Gtk.Tooltip'Elab_Spec;
      Gtk.Tooltip'Elab_Body;
      E409 := E409 + 1;
      Gtk.Tree_Selection'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      Gtk.Arguments'Elab_Spec;
      E188 := E188 + 1;
      Gtk.Print_Operation'Elab_Body;
      E323 := E323 + 1;
      Gtk.Dialog'Elab_Body;
      E204 := E204 + 1;
      Gtk.Window'Elab_Body;
      E275 := E275 + 1;
      Gtk.Tree_View'Elab_Body;
      E407 := E407 + 1;
      Gtk.Tree_View_Column'Elab_Body;
      E411 := E411 + 1;
      Gtk.Tree_Selection'Elab_Body;
      E403 := E403 + 1;
      Gtk.Tool_Button'Elab_Body;
      E528 := E528 + 1;
      Gtk.Tool_Item'Elab_Body;
      E530 := E530 + 1;
      Gtk.Text_View'Elab_Body;
      E389 := E389 + 1;
      Gtk.Text_Buffer'Elab_Body;
      E393 := E393 + 1;
      Gtk.Spin_Button'Elab_Body;
      E387 := E387 + 1;
      Gtk.Gentry'Elab_Body;
      E281 := E281 + 1;
      Gtk.Style_Context'Elab_Body;
      E309 := E309 + 1;
      Gtk.Status_Bar'Elab_Body;
      E339 := E339 + 1;
      Gtk.Scrolled_Window'Elab_Body;
      E381 := E381 + 1;
      Gtk.Notebook'Elab_Body;
      E321 := E321 + 1;
      Gtk.Menu'Elab_Body;
      E373 := E373 + 1;
      Gtk.Menu_Shell'Elab_Body;
      E379 := E379 + 1;
      Gtk.Menu_Item'Elab_Body;
      E377 := E377 + 1;
      Gtk.Grange'Elab_Body;
      E385 := E385 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E291 := E291 + 1;
      Gtk.Button'Elab_Body;
      E186 := E186 + 1;
      Gtk.Container'Elab_Body;
      E222 := E222 + 1;
      Gtk.Cell_Renderer_Toggle'Elab_Body;
      E359 := E359 + 1;
      Gtk.Cell_Renderer_Text'Elab_Body;
      E357 := E357 + 1;
      Gtk.Cell_Area'Elab_Body;
      E293 := E293 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E299 := E299 + 1;
      Gtk.Action'Elab_Body;
      E351 := E351 + 1;
      Gtk.Widget'Elab_Body;
      E228 := E228 + 1;
      E335 := E335 + 1;
      Gtk.Text_Tag_Table'Elab_Body;
      E401 := E401 + 1;
      E369 := E369 + 1;
      E301 := E301 + 1;
      Gtk.Clipboard'Elab_Body;
      E395 := E395 + 1;
      Gtk.Style'Elab_Body;
      E246 := E246 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E289 := E289 + 1;
      E285 := E285 + 1;
      Gtk.Adjustment'Elab_Body;
      E224 := E224 + 1;
      Gtk.Accel_Group'Elab_Body;
      E242 := E242 + 1;
      Glib.Menu_Model'Elab_Body;
      E375 := E375 + 1;
      Gdk.Display'Elab_Body;
      E208 := E208 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E236 := E236 + 1;
      E287 := E287 + 1;
      Gtkada.Handlers'Elab_Spec;
      E524 := E524 + 1;
      Gtkada.Builder'Elab_Body;
      E519 := E519 + 1;
      E493 := E493 + 1;
      User_Databases'Elab_Spec;
      E511 := E511 + 1;
      Server_To_Gui_Communication'Elab_Spec;
      E500 := E500 + 1;
      Concrete_Server_Logic'Elab_Spec;
      Concrete_Server_Gui_Logic'Elab_Spec;
      Concrete_Server_Gui_Logic'Elab_Body;
<<<<<<< HEAD
      E190 := E190 + 1;
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
=======
      E116 := E116 + 1;
      Concrete_Server_Logic'Elab_Body;
      E417 := E417 + 1;
      E100 := E100 + 1;
      Serverguicallbacks'Elab_Body;
      E526 := E526 + 1;
>>>>>>> origin/feature/server_logic
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
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
   --   C:\Users\Leonard\Documents\ADA\adachat\client_logic.o
   --   C:\Users\Leonard\Documents\ADA\adachat\client_ui.o
   --   C:\Users\Leonard\Documents\ADA\adachat\datatypes.o
   --   C:\Users\Leonard\Documents\ADA\adachat\gui_to_server_communication.o
   --   C:\Users\Leonard\Documents\ADA\adachat\protocol.o
   --   C:\Users\Leonard\Documents\ADA\adachat\user_databases.o
   --   C:\Users\Leonard\Documents\ADA\adachat\server_to_gui_communication.o
   --   C:\Users\Leonard\Documents\ADA\adachat\concrete_server_logic.o
   --   C:\Users\Leonard\Documents\ADA\adachat\main.o
   --   C:\Users\Leonard\Documents\ADA\adachat\concrete_server_gui_logic.o
   --   -LC:\Users\Leonard\Documents\ADA\adachat\
   --   -LC:\Users\Leonard\Documents\ADA\adachat\
=======
   --   G:\ADAChat\client_logic.o
   --   G:\ADAChat\client_ui.o
   --   G:\ADAChat\datatypes.o
   --   G:\ADAChat\gui_to_server_communication.o
   --   G:\ADAChat\protocol.o
   --   G:\ADAChat\main.o
   --   G:\ADAChat\user_databases.o
   --   G:\ADAChat\server_to_gui_communication.o
   --   G:\ADAChat\concrete_server_gui_logic.o
   --   G:\ADAChat\concrete_server_logic.o
   --   G:\ADAChat\ServerGuiEntryPoint.o
   --   G:\ADAChat\ServerGuiCallbacks.o
   --   -LG:\ADAChat\
   --   -LG:\ADAChat\
>>>>>>> origin/feature/server_logic
   --   -LC:\GtkAda\lib\gtkada\static\
   --   -LG:/hdd programme/gps/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -shared-libgcc
>>>>>>> 4877513291a6a3d10ccdfb4ed858cadf649f6436
   --   -lgnarl
   --   -lgnat
   --   -lws2_32
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
