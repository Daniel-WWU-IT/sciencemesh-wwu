<?php
/*______________________________________________________
 *======================================================
 * File: view_all.php
 * Author: George Ryall
 * Description: Controller for showing all projects in GOCDB
 *
 * License information
 *
 * Copyright � 2013 STFC
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 /*====================================================== */

function show_all_projects() {
    require_once __DIR__.'/../../../../lib/Gocdb_Services/Factory.php';
    $projects = \Factory::getProjectService()->getProjects();
    $params['Projects'] = $projects;
    show_view('project/view_all.php', $params, "Projects");
}

?>